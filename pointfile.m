A = [1 2 3 4; 4 5 6 7; 7 8 9 10]
A(:,2)      % second column of A
A(:,2:3)    % second and third column of A
A(2:3,2:3])  % second and third rows and second and third columns
A(3,:)      %third row of A
A(:)        %all elements in A  was seen as a column
A(:,:)      %A