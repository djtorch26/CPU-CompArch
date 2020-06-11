module E1 (In, Out);

	input [3:0] In;
	output [1:0] Out;

	assign Out[1] = In[2];
	assign Out[0] = (~In[2]&In[1]) | (In[2]&In[0]);   

endmodule


module E2 (In, Out);

	input [2:0] In;
	output [1:0] Out;
	
	assign Out[1] = In[2]&~In[1];
	assign Out[0] = (~In[2]&In[1]&~In[0]) | (In[2]&~In[1]&In[0]);

endmodule


module E3 (In, Out);

	input [5:0] In;
	output Out;
	
	assign Out = In[5];
	
endmodule
