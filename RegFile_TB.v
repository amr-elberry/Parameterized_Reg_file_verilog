

/********************declare testbench********************************/
module RegFile_tb ();

//parameters
// parameter width = 16 ; 
// parameter addr = 4 ;

//signal declartion

reg               rden_tb,wren_tb;
reg               clk_tb,rst_tb;
reg  [width-1:0]  wrdata_tb;
reg  [addr-1:0]   address_tb;
wire [width-1:0]  rddata_tb;

/***********************************************************************/
/***********************************************************************/
//clock generator
always #5 clk_tb = ~clk_tb;

/***********************************************************************/
/*************************DUT instantion********************************/
RegFile DUT #(parameter width=16,depth=8,addr=4) (
.CLK(clk_tb),
.RST(rst_tb),
.Address(address_tb),
.RdEn(rden_tb),
.WrEn(wren_tb),
.RdData(rddata_tb),
.WrData(wrdata_tb)
);
/*************************************************************************/
  /******************************intialization task**************************/
 task intialization ;
 begin
 clk_tb = 1'b0  ;
rden_tb  = 1'b0  ;
wren_tb  = 1'b0  ;
 end
 endtask
/***************************************************************************/
 /**************************reset task*************************************/
  task reset;
  begin
  rst_tb=1'b1;
  #5
  rst_tb=1'b1;
  #5
  rst_tb=1'b1;
 end
 endtask

 /*************************************************************************/
/******************************writing task*********************************/
task do_write ;
input [addr-1:0] Address;
input [width-1:0]  Data;

begin
#10
wren_tb  = 1'b1  ;
rden_tb  = 1'b0  ;
address_tb = Address;
wrdata_tb = Data;
end
endtask
/****************************************************************************/

/****************************reading task************************************/
task do_read_check;
input [addr-1:0] Address;
input [width-1:0] checked_data;
begin
#10
rden_tb  = 1'b1  ;
wren_tb  = 1'b0  ;
address_tb = Address ;
#10
if(rddata_tb ==checked_data)
begin
$display("test succeeded and time = %t",$time);
end
else
begin
$display("test failedand time = %t",$time);
end
end

endtask


/****************************************************************************/


/***************************intial block*************************************/
//intial block
initial
begin


  intialization();
  reset();
  do_write('b001,'b011101);
  do_write('b011,'b11011011);
  do_read_check('b001,'b011101);
  do_read_check('b011,'b11011011);

  #80;
  $stop;
  end

 

endmodule
