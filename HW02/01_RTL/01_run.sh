if [ -f '../02_REPORT/RESULT.vvp' ]; then
    rm '../02_REPORT/RESULT.vvp'
fi

if [ -f '../02_REPORT/WAVEFORM.vcd' ]; then
    rm '../02_REPORT/WAVEFORM.vcd'
fi

iverilog -g 2012 -o ../02_REPORT/RESULT.vvp ../00_TESTBED/TESTBED.sv 

if [ -f '../02_REPORT/RESULT.vvp' ]; then
    vvp ../02_REPORT/RESULT.vvp
fi