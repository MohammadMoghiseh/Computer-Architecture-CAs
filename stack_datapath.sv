`timescale 1ns/1ns
module stack8_6(input clk,rst,sld_en,serase,input [5:0]stack_in,output logic [5:0]stack_out);
logic [2:0] index;
logic [5:0] temp[0:7];
logic stack_full,stack_empty;
always @ (posedge clk)begin
	if (rst==1)begin
		
		stack_empty =1;
		index=3'b000;
		stack_full=0;
	end
	if(sld_en == 1 && stack_full==0)begin
		stack_empty <=0;
		index=index+1;
    		temp[index] <= stack_in;
    		if (index==3'b111) stack_full<=1;
  	end
	else if(serase == 1 && 1)begin
		stack_full <=0;
    		stack_out <= temp[index]; 
   		index=index-1;
		if (index==3'b000) stack_empty<=1;
  	end
end
endmodule