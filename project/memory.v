    `timescale 1ns/1ps

    module memory(clk,icode,valA,valB,valE,valP,valM,data);

        input clk;
        input [3:0] icode;
        input [63:0] valA;
        input [63:0] valB;
        input [63:0] valE;
        input [63:0] valP;

        output reg [63:0] valM;
        output reg [63:0] data;
        reg [63:0] data_mem[0:1023];

     always@(*)
        begin

            case(icode)
            
                    4'b0100 : begin
                        //rmmovq
                        data_mem[valE] = valA;

                    end

                    4'b0101 : begin
                        //mrmovq
                        valM = data_mem[valE];
                    end

                    4'b1000 : begin
                        //call
                        data_mem[valE] = valP;
                    end

                    4'b1001 : begin
                        //ret
                        valM = data_mem[valA];
                    end

                    4'b1010 : begin
                        //pushq
                        data_mem[valE] = valA;
                    end

                    4'b1011 : begin
                        //popq
                        valM = data_mem[valE];
                    end
            endcase

            data = data_mem[valE];


        end

    endmodule
