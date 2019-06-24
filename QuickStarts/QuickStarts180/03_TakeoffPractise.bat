set /p ap=Airport:
set /p rw=Runway:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--timeofday=noon ^
--prop:/systems/bp=1 ^
--prop:/systems/lapa=1 ^
--airport=%ap% ^
--aircraft=FG-Platypus-180 ^
--runway=%rw% ^
--ai-scenario=balloon_demo ^
--language=en ^
--geometry=800x600 ^           
--disable-terrasync ^
--enable-auto-coordination ^
--disable-hud-3d ^
--disable-real-weather-fetch ^
--httpd=8080 ^
--visibility-miles=30 




