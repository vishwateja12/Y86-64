module test(clk,PC,rA,rB,ValC,iCode,ifun,halt,ValP,Instr_Valid,imem_error);

input clk;
input  [63:0] PC; 
output reg [3:0] rA;
output reg [3:0] rB ;
output reg [63:0] ValC;

output reg [3:0] iCode;
output reg [3:0] ifun;
output reg halt ;

output reg [63:0] ValP;                 // it stores the new PC
output reg Instr_Valid;                     // it checks wheter itnstruction is true or false
output reg imem_error;                      // it checks where the PC is more than the instruction memeory or not
reg [7:0] Instruction_memory [0:1023] ; // it stores the insrtuction bytes
reg [63:0] Instruction;                 // it combines the needfull bytes for ValC


               

always @(posedge clk) 
begin

Instruction = {Instruction_memory [PC+2],
               Instruction_memory [PC+3],
               Instruction_memory [PC+4],
               Instruction_memory [PC+5],
               Instruction_memory [PC+6],
               Instruction_memory [PC+7],              
               Instruction_memory [PC+8],               
               Instruction_memory [PC+9] };

 imem_error = 0 ;
if (PC>1023)
imem_error = 1'b1 ;



 iCode = Instruction_memory [PC][3:0] ;
 ifun  = Instruction_memory [PC][7:4] ;

assign Instr_Valid = 1'b1 ;

case (iCode)                
    4'b0000 : 
    begin                       // halt
    halt = 1'b1 ;
    ValP = PC +1 ;
    end

    4'b0001:                    //nop
    ValP=PC+64'd1;
    
    4'b0010:                    //cmovxx
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValP = PC+64'd2;
    end

    4'b0011:                     //irmovq
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValC = Instruction ;
    ValP = PC+64'd10;
    end

    4'b0100:                     //rmmovq
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValC = Instruction ;
    ValP = PC+64'd10;
    end

    4'b0101:                    //mrmovq
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValC = Instruction ;
    ValP = PC+64'd10;
    end

    4'b0110:                     //OPq
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValP = PC+64'd10;
    end

    4'b0111:                     //jxx
    begin
    ValC={Instruction_memory[PC+1], Instruction[56:0]} ;
    ValP=PC+64'd9;
    end
    
    4'b1000:                    //call
    begin
    ValC={Instruction_memory[PC+1], Instruction[56:0]} ;
    ValP=PC+64'd9;
    end

    4'b1001:                      //ret
    ValP = PC+64'd1;

    4'b1010:                      //pushq
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValP = PC+64'd2;
    end

    4'b1011:                       //popq
    begin
    rA = Instruction_memory [PC+1][3:0] ;
    rB = Instruction_memory [PC+1][7:4] ;
    ValP = PC+64'd2;
    end

    default:  Instr_Valid=1'b0;
  
endcase
end
endmodule


