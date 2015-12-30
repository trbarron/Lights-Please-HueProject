setlocal EnableDelayedExpansion
curl http://w1.weather.gov/xml/current_obs/KBFI.xml>File.xml
for /F "delims=" %%a in ('findstr /i "temp_f" file.xml') do set temp=%%a
set /a temp=!temp:~9,-11!
set /a temp=temp*3+98
for /F "delims=" %%a in ('findstr /i "<weather>" file.xml') do set weather=%%a
set weather=%weather:~10,-10%
IF "%weather%"=="Partly Cloudy" (set wea_hue=12200)
IF "%weather%"=="Rainy" (set wea_hue=40000)
hue.bat -k <secret_code_here> -l "1 2 3" -on true -l "2" -c %temp% -h %wea_hue% -s 255 -l "1 3" -h 1 -s 1 -c %temp%
