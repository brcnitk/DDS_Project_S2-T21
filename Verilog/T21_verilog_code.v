// SMART RING WITH BODY VITAL SENSORS
//S2_T21
//1. 221CS217 , Dhanush V , dhanushv.221cs217@nitk.edu.in , 9353241312
//2. 221CS222 , Harsha J Gundapalli , harshajgundapalli.221cs222@nitk.edu.in ,8792251009
//3. 221CS226 , Isiri Dinesh S , isiridineshs.221cs226@nitk.edu.in , 7349437557


module magComp (   //Module for an 8-bit comparator
input [7:0] In1,
input [7:0] In2,
output Gt,
);

reg Gt;

always @ (In1 or In2) // Check the state of the input lines
begin
Gt <= (In1 > In2) ? 1’b1 : 1’b0; // Check for greater than condition
end module

module full_adder(output cout, s , input a, b, cin); // Module for full_adder
  assign S = a ^ b ^ cin;
  assign Cout = (a & b) | (b & cin) | (a & cin);
end module

module subtractor(  //Module for 8-bit adder subtractor circuit
    output cout,    //MSB, determines if answer is positive or negative
    output [7:0] s,
    input [7:0] a,
    input [7:0] b,
    input cin // if cin = 1, subtract, if cin = 0, add. 
    );
    
    wire [7:0] bin; // bin XOR'ed with cin to get its compliment 
    assign bin[0] = b[0]^cin;
    assign bin[1] = b[1]^cin;
    assign bin[2] = b[2]^cin;
    assign bin[3] = b[3]^cin;
    assign bin[4] = b[4]^cin;                          
    assign bin[5] = b[5]^cin;
    assign bin[6] = b[6]^cin;
    assign bin[7] = b[7]^cin;
    
      
    wire [8:1] carry; // subtraction using full adders
     full_adder FA0(carry[1],s[0],a[0],bin[0],cin);
     full_adder FA1(carry[2],s[1],a[1],bin[1],carry[1]);
     full_adder FA2(carry[3],s[2],a[2],bin[2],carry[2]);
     full_adder FA3(carry[4],s[3],a[3],bin[3],carry[3]);
     full_adder FA4(carry[5],s[4],a[4],bin[4],carry[4]);
     full_adder FA5(carry[6],s[5],a[5],bin[5],carry[5]);
     full_adder FA6(carry[7],s[6],a[6],bin[6],carry[6]);
     full_adder FA7(carry[8],s[7],a[7],bin[7],carry[7]);
     
     assign cout = cin^carry[8];// Final carry over 
   
end module


module S2_T21(A,B,C,F1,F2,F3,F4,X,D,E)  // Final Module for the circuit 
	input [0:7] A; // Inputs given from the sensors
	input [0:7] B;
	input [0:7] C;
	input [0:7] F1; // Fixed inputs specified in advance
	input [0:7] F2;
	input [0:7] F3;
	input [0:7] F4;
	input X;
	output [0:7] D; // Gives us the amount of oxygen given out
	output E; // Tells us if it is an emergency or not 
  
	wire [0:6] w;
	magComp C1(A,F1,w[0]); // Check the temperature readings 
	magComp C2(B,F2,w[1]); // Check the heart rate readings
	subtractor S1(w[2],D,C,F3,X); // Difference in the oxygen level
	magComp C3(D,F4,w[3]); // Check with the critical limit
	AND A1(w[4],w[0],w[1]);  
	AND A2(w[5],w[1],w[3]);
	AND A3(w[6],w[0],w[3]);
	OR O1(E,w[4],w[5],w[6]); // Tells is it an emergency or not
end module
	
	
	
	


	