# Binary-Calculator
A binary calculator I made during my summer practice at AMD. 

[![Bynary Calculator](https://img.youtube.com/vi/h-6Vby1vgEM/0.jpg)](https://www.youtube.com/watch?v=h-6Vby1vgEM "Binary Calculator")

---

The calculator can do basic arithmetic and store calculations in memory.

It is PIN protected (input_key), the PIN is 0101 (LSB first).
After the correct PIN is provided, the same line will be used to select the mode:  
    &emsp; MODE 1 is for working with memory;  
    &emsp; MODE 0 will bypass the memory and will simply output the calculations.

Din is the divisor which will be used to generate our new clock (clk_txt).
Freq(clk_tx) = Freq(clk) / Din

Subtraction results use two's complement so you will get signed numbers in an unsigned format (Keep that in mind if you want to use the module in other modules).


---

Each subdirectory contains the module and its respective testbench.

