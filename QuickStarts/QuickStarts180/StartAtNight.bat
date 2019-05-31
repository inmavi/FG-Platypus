set /p ap=Airport:
set /p rw=Runway:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--timeofday=midnight ^
--airport=%ap% ^
--aircraft=FG-Platypus-180 ^
--runway=%rw% ^
--language=en ^
--prop:/systems/saloft=0 ^
--prop:/systems/fl=1 ^
--geometry=800x600 ^           
--disable-ai-models ^
--disable-ai-traffic ^
--disable-terrasync ^
--enable-auto-coordination ^
--disable-hud-3d ^
--disable-real-weather-fetch ^
--visibility-miles=20 




