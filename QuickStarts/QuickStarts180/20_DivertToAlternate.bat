set /p ap=Airport:
set /p rw=Runway:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--timeofday=noon ^
--airport=%ap% ^
--aircraft=FG-Platypus-180 ^
--runway=%rw% ^
--prop:/systems/div=1 ^
--language=en ^
--geometry=800x600 ^           
--disable-terrasync ^
--enable-auto-coordination ^
--disable-hud-3d ^
--disable-real-weather-fetch ^
--httpd=8080 ^
--ai-scenario=balloon_demo ^
--visibility-miles=30 




