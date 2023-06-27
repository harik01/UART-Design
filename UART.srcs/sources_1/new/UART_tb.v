module UART_tb;
  reg clk,start,stop;
  reg [7:0] in;
  wire out,t_done,t_active,r_done;
  wire [7:0] O;

  transmit inst(clk,start,in,stop,t_active,out,t_done);
  receive inst1(out,clk,O,r_done);
  
   initial
     repeat(2000)
    #200 clk=~clk;   // baud rate=9600 bps
                      // frequency of our clock input=250 kHz
                      // 250000/9600=26 clock cyles per bit
                     //We have a fixed clk input 
  initial
    begin
      $dumpfile("UART_tb.vcd");
      $dumpvars(0,UART_tb);
      clk=0;
      start=1'b0;
      in=8'b11010001;
      stop=1'b1;
    end
  

  
  initial 
    begin
    $monitor($time,"   t_active=%b    out=%b     t_done=%b",t_active,out,t_done);
      $monitor($time,"   O=%b              r_done=%b",O,r_done);
    end
        
  
endmodule 