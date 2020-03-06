.orig x3000

lea r0, test_output_3
PUTS

HALT
test_output_3 .stringz "Test Failed: 'success' != 'Failed: Program i/o differs from solution io. **********************\ \n * The Busyness Server *\\n**********************\\n1. Check to see whether all machines are busy\\n2. Check to see whether all machines are free\\n3. Report the number of busy machines\\n4. Report the number of free machines\\n5. Report the status of machine n\\n6. Report the number of the first available machine\\n7. Quit\\n5\\nEnter which machine you want the status of (0 - 15), followed by ENTER: 15\\nMachine 15 is free\\n**********************\\n* The Busyness Server *\\n**********************\\n1. Check to see whether all machines are busy\\n2. Check to see whether all machines are free\\n3. Report the number of busy machines\\n4. Report the number of free machines\\n5. Report the status of machine n\\n6. Report the number of the first available machine\\n7. Quit\\n\\n\\nINVALID INPUT\\n**********************\\n* The Busyness Server *\\n**********************\\n1. Check to see whether all machines are busy\\n2. Check to see whether all machines are free\\n3. Report the number of busy machines\\n4. Report the number of free machines\\n5. Report the status of machine n\\n6. Report the number of the first available machine\\n7. Quit\\n7\\nGoodbye!\\n Should be: **********************\\n* The Busyness Server *\\n**********************\\n1. Check to see whether all machines are busy\\n2. Check to see whether all machines are free\\n3. Report the number of busy machines\\n4. Report the number of free machines\\n5. Report the status of machine n\\n6. Report the number of the first available machine\\n7. Quit\\n5\\nEnter which machine you want the status of (0 - 15), followed by ENTER: 15\\nMachine 15 is free\\n**********************\\n* The Busyness Server *\\n**********************\\n1. Check to see whether all machines are busy\\n2. Check to see whether all machines are free\\n3. Report the number of busy machines\\n4. Report the number of free machines\\n5. Report the status of machine n\\n6. Report the number of the first available machine\\n7. Quit\\n7\\nGoodbye!\\n"


.END


Test Failed: 'success' != 'Failed: Program i/o differs from solution io. 
"**********************\
* The Busyness Server *\
**********************\
1. Check to see whether all machines are busy\
2. Check to see whether all machines are free\
3. Report the number of busy machines\
4. Report the number of free machines\
5. Report the status of machine n\
6. Report the number of the first available machine\
7. Quit\
5\
Enter which machine you want the status of (0 - 15), followed by ENTER: 15\
Machine 15 is free\
**********************\
* The Busyness Server *\
**********************\
1. Check to see whether all machines are busy\
2. Check to see whether all machines are free\
3. Report the number of busy machines\
4. Report the number of free machines\
5. Report the status of machine n\
6. Report the number of the first available machine\
7. Quit\
\
\
INVALID INPUT\
**********************\
* The Busyness Server *\
**********************\
1. Check to see whether all machines are busy\
2. Check to see whether all machines are free\
3. Report the number of busy machines\
4. Report the number of free machines\
5. Report the status of machine n\
6. Report the number of the first available machine\
7. Quit\
7\
Goodbye!\
" Should be: 
"**********************\\n* The Busyness Server *\\n**********************\
1. Check to see whether all machines are busy\
2. Check to see whether all machines are free\
3. Report the number of busy machines\
4. Report the number of free machines\
5. Report the status of machine n\
6. Report the number of the first available machine\
7. Quit\
5\
Enter which machine you want the status of (0 - 15), followed by ENTER: 15\
Machine 15 is free\
**********************\
* The Busyness Server *\
**********************\
1. Check to see whether all machines are busy\
2. Check to see whether all machines are free\
3. Report the number of busy machines\
4. Report the number of free machines\
5. Report the status of machine n\
6. Report the number of the first available machine\
7. Quit\
7\
Goodbye!\
"'












\n7. Quit\\n7\\nGoodbye!\\n" 
\n7. Quit\\n7\\nGoodbye!\\n"








\n7. Quit\\n
\\n
\\n
INVALID INPUT\\n


\n7. Quit\\n
7\\n
Goodbye!\\n

\n7. Quit\\n7\\nGoodbye!\\n
