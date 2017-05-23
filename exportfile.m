num_array=[1 2 3 4;4 5 6 7;7 8 9 0];
save array_data1.out num_array -ASCII;
type array_data1.out
dlmwrite('array_data2.out',num_array,' ');
type array_data2.out
h='hello';
save textdata.out h -ascii
type textdata.out 
