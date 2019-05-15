set /p ap=Airport:
set /p rw=Runway:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--timeofday=noon ^
--airport=%ap% ^
--aircraft=WarriorII-180 ^
--runway=%rw% ^
--language=en ^
--geometry=800x600 ^
--prop:/systems/fas=1 ^  
--prop:/systems/starts=200 ^          
--disable-terrasync ^
--enable-auto-coordination ^
--disable-hud-3d ^
--disable-real-weather-fetch ^
--httpd=8080 ^
--visibility-miles=30 




