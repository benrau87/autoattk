@echo off
set "workingdir=%cd%"
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "CurrentDate=%YYYY%-%MM%-%DD%_%HH%-%Min%"

if not exist "%cd%\Results\%CurrentDate%"  mkdir %cd%\Results\%CurrentDate%
set "outputdir=%cd%\Results\%CurrentDate%"

@echo on
cd %cd%\Input
echo all | .\main.exe
python truepositives.py -f scanreport.xml

@echo off 
echo D | xcopy /y result %outputdir%\result 
xcopy /y index.html %outputdir%\* /q
xcopy /y truepositives.txt %outputdir%\* /q


rmdir result /q
del index.html /q
del truepositives.txt /q
del *.xml /q


