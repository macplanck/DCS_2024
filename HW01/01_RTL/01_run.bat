@echo off

iverilog -g 2012 -o ..\02_REPORT\run.vvp ..\00_TESTBENCH\TESTBED.sv

IF %ERRORLEVEL% NEQ 0 (
    exit /b 0
)

vvp ..\02_REPORT\run.vvp
exit /b 0
