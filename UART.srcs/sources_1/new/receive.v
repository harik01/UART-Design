module receive(I,clk,O,r_done);
  
  input I,clk;
  
  output reg [7:0] O;
  output reg r_done=0;
  
  parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;
    
  reg [1:0] state=S0;
  
  integer cpb=26;
  
  reg [7:0] clk_count=0,i=0;

  always @(posedge clk)
   begin
     case(state)
      S0: begin
        if(I==0) state=S1;
           else state=S0;
           r_done=0;
           end
       
     S1:  begin                           
          if(clk_count<cpb-1)
             begin 
                clk_count<=clk_count+1;
                state=S1;
              end
           else
             begin
              state=S2;
              clk_count=0;
             end
          end 
       
       S2: begin            
            if(clk_count<cpb-1)
              begin
                clk_count<=clk_count+1;
                state=S2;
                O[i]=I;
              end
            else
             begin
              clk_count=0;
              if(i<7)
                begin
                 state=S2;
                 i<=i+1;
                end
               else
                 begin 
                  i=0;
                  state=S3;
                  r_done=1;
                 end
             end
          end 
       
       S3: begin      
           if(I==1)
           begin
              if(clk_count<cpb-1)
               begin 
                clk_count<=clk_count+1;
                state=S3;
               end
             else
               begin
                state=S0;
                clk_count=0;
                cpb<=cpb*2;
               end
           end
         end
      endcase
   end
endmodule