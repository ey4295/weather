A=[1 2 3;4 5 6;7 8 9]
B=[1 2 3;42 45 103;55 56 57]
intersect(A,B)  
disp("this is common elements,returned in sored order")
intersect(A,B,'rows')
disp("returns the rows common to both A and B")
ismember(A,B)
disp("Returns an array the same size as A, containing 1 (true) where the elements of A are found in B. Elsewhere, it returns 0 (false).")
ismember(A,B,'rows')
disp("Treats each row of A and each row of B as single entities and returns a vector containing 1 (true) where the rows of matrix A are also rows of B.")

