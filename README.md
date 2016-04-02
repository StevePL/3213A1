# ENGN3213 Assignment 1

###Report

[Overleaf](https://www.overleaf.com/4752390rdbzzc)

###TODO

* Watch mini-lecture on serial comms
* Testbenches
* UCF
* The rest of the functions 2 and 3
* Combine all in one

### Simulation HOWTO

1. `iverilog $file $tb`
2. `vvp a.out`
3. `gtkwave $dump`

### Status

* **[untested]** `cereal.v` - serial state machine (takes data[7:0] and sends it)
* **[working]** `clockdiv.v` - variable rate heartbeat (TB is in `/src/tb/tb_clockdiv.v`)
* **[working]** `debouncer.v` - pushbutton single pulse (TB in `/src/tb/tb_debouncer.v`)
* **[untested]** `keyboard.v` - main file, instantiates all others and reads input

###Labs

* TUE 05APR 0900-1300
* MON 11APR 0900-1300
* TUE 19APR 1500-1700
* TUE 26APR 1500-1700
* THU 28APR 1100-1300
* FRI 29APR 0900-1300
