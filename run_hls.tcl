# Create a project
set impl_sel "solution_0"

# Delete previous project and open the new one
delete_project convolution
open_project convolution
open_solution ${impl_sel}

# Set the top-level function
set_top top_wrapper

# Add design files for synthesis (remove -tb here)
add_files /home/lorenzor/workspace/convolution/top_wrapper.cpp
add_files /home/lorenzor/workspace/convolution/top_wrapper.h
add_files /home/lorenzor/workspace/convolution/conv.h
add_files /home/lorenzor/workspace/convolution/parameter.h

# Add testbench file (only for simulation, keep -tb here)
add_files -tb /home/lorenzor/workspace/convolution/conv_tb.cpp

# Define technology and clock rate
set_part {xck26-sfvc784-2LV-c}
create_clock -period 5

# Run simulation (csim)
#csim_design

# Run synthesis (csynth)
csynth_design

cosim_design 
#-trace_level all

#export_design -flow syn
#-rtl verilog

# Exit the script
exit