@echo off

iverilog -g 2012 -o ..\02_REPORT\RESULT.vvp ..\00_TESTBENCH\TESTBED.sv

IF %ERRORLEVEL% NEQ 0 (
    exit /b 0
)

vvp ..\02_REPORT\RESULT.vvp
exit /b 0
