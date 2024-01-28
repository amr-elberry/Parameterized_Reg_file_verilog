/*********************Reg File 8*16 *************************/

//port list &declaration
module RegFile #(parameter width=16,depth=8,addr=4)(
  input  wire              RdEn,WrEn,
  input  wire              CLK,RST,
  input  wire [width-1:0]  WrData,
  input  wire [addr-1:0]   Address,
  output reg  [width-1:0]  RdData);
  
  reg [width-1:0] Data [depth-1:0];
  integer i;
  
  // sequantional part to write and read operation on posedge
  always@(posedge CLK or negedge RST)
  begin
    if(!RST) //active low reset
      begin
      for(i=0;i<depth;i=i+1)
      begin
        Data[i] <= 0;
      end
      end
      else if(RdEn && !WrEn)
        begin
        RdData <= Data[Address];
        end
      
      else if(!RdEn && WrEn)
        begin
        Data[Address] <= WrData;
        end
  end
endmodule

