`timescale 1ns / 1ps
module ALU4bit(operand1,operand2,opcode,result,fault);
    input  [3:0] operand1,operand2;     
    input  [1:0] opcode;
    input fault;                
    output reg [7:0] result;    
    parameter [1:0] 
        ADD  = 2'b00,
        SUB  = 2'b01,
        MUL  = 2'b10,
        AND  = 2'b11;
 
    always @(*) begin
    if (fault)
    begin
    case (opcode)
          
            ADD: result = operand1 ^ operand2;
            SUB: result = operand1 | operand2;
            MUL: result = {operand1,operand2};
            AND: result = {operand2,operand1};
         default:
             result = 8'd0;
         endcase
    end
    else
    begin
        case (opcode)
          
            ADD: result = operand1 + operand2;
            SUB: result = operand1 - operand2;
            MUL: result = operand1 * operand2;
            AND: result = operand1 & operand2;
         default:
             result = 8'd0;
         endcase
    end
    end
endmodule

module ALU4bitextra(operand1,operand2,opcode,result);
    input  [3:0] operand1,operand2;     
    input  [1:0] opcode;             
    output reg [7:0] result;    
    parameter [1:0] 
        ADD  = 2'b00,
        SUB  = 2'b01,
        MUL  = 2'b10,
        AND  = 2'b11;
 
    always @(*)
        begin
        case (opcode)
          
            ADD: result = operand1 + operand2;
            SUB: result = operand1 - operand2;
            MUL: result = operand1 * operand2;
            AND: result = operand1 & operand2;
         default:
             result = 8'd0;
         endcase
         end
endmodule

/*module dmux4x1x2 (in,s,out1,out2);
input [3:0]in;
input s;
output reg [3:0]out1,out2;
always@(*)
begin
if (s)
out2=in;
else out1=in;
end
endmodule
module dmux2x1x2 (in,s,out1,out2);
input [1:0]in;
input s;
output reg [1:0]out1,out2;
always@(*)
begin
if (s)
out2=in;
else out1=in;
end
endmodule*/

module mux8x2x1 (a,b,s,f);
input [7:0]a,b;
input s;
output [7:0]f;
assign f=s?b:a;
endmodule

/*module shiftinput (shift,operand1,operand2,opcode,opr1alu,opr1alue,opr2alu,opr2alue,opc1,opc2);
    input  [3:0] operand1,operand2;     
    input  [1:0] opcode;       
    input shift; 
    output [3:0]opr1alu,opr1alue,opr2alu,opr2alue;
    output [1:0]opc1,opc2;      
dmux4x1x2 x1(operand1,shift,opr1alu,opr1alue);
dmux4x1x2 x2(operand2,shift,opr2alu,opr2alue);
dmux2x1x2 x3(opcode,shift,opc1,opc2);    
endmodule*/

module binarytobcd4bit(bin,bcd1,bcd0);
input [3:0] bin; 
output [3:0] bcd1,bcd0;
assign bcd1 = (bin/4'd10);
assign bcd0 = (bin%4'd10);
endmodule

module binarytobcd8bit(binary,bcd2, bcd1,bcd0);
input [7:0] binary; 
output [3:0] bcd2,bcd1,bcd0;
wire [7:0]w;
assign bcd2 = (binary/8'd100);
assign w = binary/4'd10;
assign bcd1 = (w%4'd10);
assign bcd0 = (binary%4'd10);
endmodule

module inputdisplay (operand1, operand2, digit1,digit2,digit3,digit4);
input [3:0] operand1, operand2;
output [3:0] digit1,digit2,digit3,digit4;
binarytobcd4bit x1(operand1,digit2,digit1);
binarytobcd4bit x2(operand2,digit4,digit3);
endmodule

module outputdisplay (result, digit1,digit2,digit3,digit4);
input [7:0]result;
output [3:0] digit1,digit2,digit3,digit4;
assign digit4=0000;
binarytobcd8bit x1(result,digit3, digit2,digit1);
endmodule

module clockdivide(clk, nclk);
input clk;
output reg nclk;
reg [31:0]count=32'd0;
always@(posedge clk)
begin
count=count+1;
nclk=count[16];
end
endmodule

module refresh_counter(rclock,rcounter);
input rclock;
output reg[1:0]rcounter=2'b00;
always@(posedge rclock)
rcounter<=rcounter+1;
endmodule

module anode_control(rcounter,anode);
input [1:0]rcounter;
output reg [7:0]anode;
always@(rcounter)
begin
case(rcounter)
2'b00: anode=8'b11111110;
2'b01: anode=8'b11111101;
2'b10: anode=8'b11111011;
2'b11: anode=8'b11110111;
endcase
end
endmodule

module bcd_control(digit1,digit2,digit3,digit4,rcounter,bcd);
input [3:0]digit1,digit2,digit3,digit4;
input [1:0]rcounter;
output reg [3:0]bcd=4'b0000;
always@(rcounter,digit1,digit2,digit3,digit4)
begin
case(rcounter)
2'b00: bcd=digit1;
2'b01: bcd=digit2;
2'b10: bcd=digit3;
2'b11: bcd=digit4;
endcase
end
endmodule

module segment7(
     bcd,
     seg
    );
     
     //Declare inputs,outputs and internal variables.
     input [3:0] bcd;
     output [6:0] seg;
     reg [6:0] seg;

//always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : seg = 7'b1000000;
            1 : seg = 7'b1111001;
            2 : seg = 7'b0100100;
            3 : seg = 7'b0110000;
            4 : seg = 7'b0011001;
            5 : seg = 7'b0010010;
            6 : seg = 7'b0000010;
            7 : seg = 7'b1111000;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0010000;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 7'b1111111; 
        endcase
    end
    
endmodule

module mux4x2x1 (a,b,s,f);
input [3:0]a,b;
input s;
output [3:0]f;
assign f=s?b:a;
endmodule
module dff(d,clk,q);
input d,clk;
output reg q=0;
always @(posedge clk)
q=d;
endmodule

module TPG (clk,q);
input clk;
output [3:0]q;
wire q0,q1,q2,q3, exorout;
dff x1(exorout,clk,q0);
dff x2(q0,clk,q1);
dff x3(q1,clk,q2);
dff x4(q2,clk,q3);
xnor (exorout,q0,q3);
assign q={q3,q2,q1,q0};
endmodule

module clockdivideTPG(clk, nclk);
input clk;
output reg nclk;
reg [31:0]count=32'd0;
always@(posedge clk)
begin
count=count+1;
nclk=count[22];
end
endmodule
module clockdividetest(clk, nclk);
input clk;
output reg nclk;
reg [31:0]count=32'd0;
always@(posedge clk)
begin
count=count+1;
nclk=count[29];
end
endmodule

module bistcontroller(a,b,opcode,clk,fault,result,faulty);
input [3:0]a,b;
input [1:0]opcode;
input fault;
input clk;
output [7:0]result;
output faulty;
wire [3:0] testa,testb,fa,fb;
wire [7:0] alu, alue,w;
wire TPGclk, TESTclk;
clockdivideTPG x8(clk, TPGclk);
clockdividetest x9(clk, TESTclk);
TPG x1(TPGclk,testa);
TPG x2(TPGclk,testb);
mux4x2x1 x3(a,testa,TESTclk,fa);
mux4x2x1 x4(b,testb,TESTclk,fb);
ALU4bit x6(fa,fb,opcode,alu,fault);
ALU4bitextra x5(fa,fb,opcode,alue);
mux8x2x1  x7(alu,alue,faulty,result);
xor (w[0],alu[0],alue[0]);
xor (w[1],alu[1],alue[1]);
xor (w[2],alu[2],alue[2]);
xor (w[3],alu[3],alue[3]);
xor (w[4],alu[4],alue[4]);
xor (w[5],alu[5],alue[5]);
xor (w[6],alu[6],alue[6]);
xor (w[7],alu[7],alue[7]);
or (faulty,w[0],w[1],w[2],w[3],w[4],w[5],w[6],w[7]);
endmodule

module main(operand1,operand2,opcode,clk,d,seg,anode,fault,faulty);
input [3:0] operand1,operand2;
input [1:0]opcode;
input d;
input clk;
input fault;
output faulty;
output [6:0]seg;
output [7:0]anode;
wire nclk;
wire [1:0]rcounter,opc1,opc2;
wire [3:0]bcd;
wire [7:0] resultalu, resultalue, result;
wire [3:0] in1,in2,in3,in4,out1,out2,out3,out4;
//wire [3:0] opr1alu,opr1alue,opr2alu,opr2alue;
wire [3:0]digit1,digit2,digit3,digit4;
clockdivide x1(clk, nclk);
refresh_counter x2(nclk,rcounter);
anode_control x3(rcounter,anode);
inputdisplay x4(operand1, operand2, in1,in2,in3,in4);
//shiftinput x13(shift,operand1,operand2,opcode,opr1alu,opr1alue,opr2alu,opr2alue,opc1,opc2);
//ALU4bit x5(operand1,operand2,opcode, resultalu,fault);
//ALU4bitextra x14(operand1,operand2,opcode,resultalue);
bistcontroller x16(operand1,operand2,opcode,clk,fault,result,faulty);
//mux8x2x1 x15(resultalu,resultalue,faulty,result);
outputdisplay x6(result, out1,out2,out3,out4);
mux4x2x1 x7(in1,out1,d,digit1);
mux4x2x1 x8(in2,out2,d,digit2);
mux4x2x1 x9(in3,out3,d,digit3);
mux4x2x1 x10(in4,out4,d,digit4);
bcd_control x11(digit1,digit2,digit3,digit4,rcounter,bcd);
segment7 x12(bcd,seg);
endmodule

module main_top(clk,sw,led,an,seg);
input clk;
input [11:0]sw;
output led;
output [7:0]an;
output [6:0]seg;
main m1(sw[3:0],sw[7:4],sw[9:8],clk,sw[10],seg,an,sw[11],led);
endmodule
