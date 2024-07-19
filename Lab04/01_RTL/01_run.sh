# Initialize commands and log file location
log_file="./../02_REPORT/syn.log"

cmd_1="iverilog -g 2012 -o ../02_REPORT/RESULT.vvp ../00_TESTBED/TESTBED.sv"
cmd_2="vvp ../02_REPORT/RESULT.vvp"


: > $log_file                       # initialize syn.log 
$cmd_1 2>&1 | tee -a "$log_file"    # run command 1 and store outputs into syn.log
err=$(grep -c error $log_file)      # read errors

if [ $err -eq 0 ]; 
then
    $cmd_2 2>&1 | tee -a "$log_file"
else
    echo "$err errors generated"
    exit 1
fi