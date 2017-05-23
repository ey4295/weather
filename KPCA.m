function [eigvector, eigvalue,Y] = KPCA(X,r,opts)
% Kernel Principal Component Analysis
% [eigvector, eigvalue,Y] = KPCA(X,r,opts)
% Input:
% X: d*N data matrix;Each column vector of X is a sample vector.
% r: Dimensionality of reduced space (default: d)
% opts:   Struct value in Matlab. The fields in options that can be set:
% KernelType  -  Choices are:
%                  'Gaussian'      - exp{-gamma(|x-y|^2)}
%                  'Polynomial'    - (x'*y)^d
%                  'PolyPlus'      - (x'*y+1)^d
%         gamma       -  parameter for Gaussian kernel
%         d           -  parameter for polynomial kernel
%
% Output:
% eigvector: N*r matrix;Each column is an embedding function, for a new
%            data point (column vector) x,  y = eigvector'*K(x,:)'
%            will be the embedding result of x.
%            K(x,:) = [K(x1,x),K(x2,x),...K(xN,x)]
% eigvalue: The sorted eigvalue of KPCA eigen-problem.
% Y       : Data matrix after the nonlinear transform
if nargin<1  %判断函数输入变量的个个数
    error('Not enough input arguments.')
end
[d,N]=size(X);  %原始输入数据的维数
if nargin<2     %若只输入一个参数，则默认将原始输入数据的行数作为降维后的维数
    r=d;
end
%% Ensure r is not bigger than d

if r>d
    r=d;
end;
% Construct the Kernel matrix K：创建核矩阵
K =ConstructKernelMatrix(X,[],opts);
% Centering kernel matrix，修正核函数
One_N=ones(N)./N;
Kc = K - One_N*K - K*One_N + One_N*K*One_N;
clear One_N;
% Solve the eigenvalue problem N*lamda*alpha = K*alpha
if N>1000 && r
    % using eigs to speed up!
    opts.disp=0;
    [eigvector, eigvalue] = eigs(Kc,r,'la',opts);%求所有特征值和特征向量，对实对称问题：'la'表示最大特征值；'sa'为最小特征值
    eigvalue = diag(eigvalue);%对角线元素是eigvalue的矩阵
else
    [eigvector, eigvalue] = eig(Kc);
    eigvalue = diag(eigvalue);
    [junk, index] = sort(-eigvalue);
    % b=sortrows(a,2)  a 为要排序的矩阵。2表示按第几列进行排序，整数代表升序，负数代表降序。
    %即对eigvalue矩阵进行降序排列
    eigvalue = eigvalue(index);
    eigvector = eigvector(:,index);
end
if r < length(eigvalue)
    eigvalue = eigvalue(1:r);
    eigvector = eigvector(:, 1:r);
end
% Only reserve the eigenvector with nonzero eigenvalues
maxEigValue = max(abs(eigvalue));  %abs()函数用于求实数的绝对值
eigIdx = find(abs(eigvalue)/maxEigValue < 1e-6);
eigvalue (eigIdx) = [];
eigvector (:,eigIdx) = [];
% Normalizing eigenvector
for i=1:length(eigvalue)
    eigvector(:,i)=eigvector(:,i)/sqrt(eigvalue(i));
end;
if nargout >= 3   %输出参数的个数
    % Projecting the data in lower dimensions
    Y = eigvector'*K;
end
function K=ConstructKernelMatrix(X,Y,opts)
% function K=ConstructKernelMatrix(X,Y,opts)
% Usage:
%   opts.KernelType='Gaussian';
% K = ConstructKernelMatrix(X,[],opts)
%   K = ConstructKernelMatrix(X,Y,opts)
% Input:
% X: d*N data matrix;Each column vector of X is a sample vector.
% Y: d*M data matrix;Each column vector of Y is a sample vector.
% opts:   Struct value in Matlab. The fields in options that can be set:
%         KernelType  -  Choices are:
%                  'Gaussian'      - exp{-gamma(|x-y|^2)}
%                  'Polynomial'    - (x'*y)^d
%                  'PolyPlus'      - (x'*y+1)^d
%         gamma       -  parameter for Gaussian kernel
%         d           -  parameter for polynomial kernel
% Output:
% K N*N or N*M matrix
if nargin<1
    error('Not enough input arguments.')
end
if (~exist('opts','var'))
    opts = [];
else
    if ~isstruct(opts)
        error('parameter error!');
    end
end
N=size(X,2);
if isempty(Y)
    K=zeros(N,N);
else
    M=size(Y,2);
    if size(X,1)~=size(Y,1)
        error('Matrixes X and Y should have the same row dimensionality!');
    end
    K=zeros(N,M);
end
%=================================================
% 函数功能： 判断输入是否是结构体数组的域（成员）。调用格式：
%    tf = isfield(S, 'fieldname')
if ~isfield(opts,'KernelType')
    opts.KernelType = 'Gaussian';
end
switch lower(opts.KernelType)
    case {lower('Gaussian')}        %  exp{-gamma(|x-y|^2)}
        if ~isfield(opts,'gamma')
            opts.gamma = 0.5;
        end
    case {lower('Polynomial')}      % (x'*y)^d
        if ~isfield(opts,'d')
            opts.d = 1;
        end
    case {lower('PolyPlus')}      % (x'*y+1)^d
        if ~isfield(opts,'d')
            opts.d = 1;
        end
    otherwise
        error('KernelType does not exist!');
end
%核函数的构建
switch lower(opts.KernelType)
    case {lower('Gaussian')}
        if isempty(Y)
            for i=1:N
                for j=i:N
                    dist = sum(((X(:,i) - X(:,j)).^2));
                    temp=exp(-opts.gamma*dist);
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end
                end
            end
        else
            for i=1:N
                for j=1:M
                    dist = sum(((X(:,i) - Y(:,j)).^2));
                    K(i,j)=exp(-opts.gamma*dist);
                end
            end
        end
    case {lower('Polynomial')}
        if isempty(Y)
            for i=1:N
                for j=i:N
                    temp=(X(:,i)'*X(:,j))^opts.d;
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end;
                end
            end
        else
            for i=1:N
                for j=1:M
                    K(i,j)=(X(:,i)'*Y(:,j))^opts.d;
                end
            end
        end
    case {lower('PolyPlus')}
        if isempty(Y)
            for i=1:N
                for j=i:N
                    temp=(X(:,i)'*X(:,j)+1)^opts.d;
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end;
                end
            end
        else
            for i=1:N
                for j=1:M
                    K(i,j)=(X(:,i)'*Y(:,j)+1)^opts.d;
                end
            end
        end
    otherwise
        error('KernelType does not exist!');
end