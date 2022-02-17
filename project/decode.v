`timescale 1ns/1ps

module decode(clk,icode,rA,rB,cnd,valA,valB,valM,valE,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14) ;

input clk;
input icode;
input  rA;
input rB;
input [63:0] valM;
input [63:0] valE;
input cnd;

output reg [63:0] valA;
output reg [63:0] valB;

output reg [63:0] rax;
output reg [63:0] rcx;
output reg [63:0] rdx;
output reg [63:0] rbx;
output reg [63:0] rsp;
output reg [63:0] rbp;
output reg [63:0] rsi;
output reg [63:0] rdi;
output reg [63:0] r8;
output reg [63:0] r9;
output reg [63:0] r10;
output reg [63:0] r11;
output reg [63:0] r12;
output reg [63:0] r13;
output reg [63:0] r14;

reg [63:0] reg_mem[0:14];

\\ pre define values.
initial begin
    reg_mem[0] = 64'd0;
    reg_mem[1] = 64'd2;
    reg_mem[2] = 64'd4;
    reg_mem[3] = 64'd6;
    reg_mem[4] = 64'd8;
    reg_mem[5] = 64'd16;
    reg_mem[6] = 64'd32;
    reg_mem[7] = 64'd64;
    reg_mem[8] = 64'd128;
    reg_mem[9] = 64'd256;
    reg_mem[10] = 64'd512;
    reg_mem[11] = 64'd1024;
    reg_mem[12] = 64'd2048;
    reg_mem[13] = 64'd4096;
    reg_mem[14] = 64'd8192;
end


always@(*)

begin

    case(icode)

    4'b0010 : begin
       //cmovxx
       valA=reg_mem[rA]; 

    end

    4'b0100 : begin
        //rmmovq
        valA=reg_mem[rA];
        valB=reg_mem[rB];
    end  

    4'b0101 : begin
        //mrmovq
        valB = reg_mem[rB];
    end

    4'b0110 : begin
        //OPq
        valA = reg_mem[rA];
        valB = reg_mem[rB];

    end

    4'b1000 : begin 
        //call
        valB=reg_mem[4];
    end 

    4'b1001 : begin
        //ret
        valA = reg_mem[4];
        valB = reg_mem[4];
    end

    4'b1010 : begin
        //pushq
        valA = reg_mem[rA];
        valB = reg_mem[4];
    end

    4'b1011 : begin 
        //popq
        valA = reg_mem[4];
        valB = reg_mem[4];
    end

    endcase 

    rax 
    rcx
    rdx
    rbx
    rsp
    rbp
    rsi
    rdi
    r8
    r9
    r10
    r11
    r12
    r13
    r14