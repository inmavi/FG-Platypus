
set /p ap=Airport:
set /p pa=ParkPos:


"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--airport=%ap% ^
--parkpos=%pa% ^
--timeofday=afternoon ^
--language=en ^
--aircraft=FG-Platypus-180 ^
--geometry=800x600 ^
--enable-auto-coordination ^
--disable-real-weather-fetch ^
--disable-ai-models ^
--disable-terrasync ^
--disable-ai-traffic ^
--disable-hud-3d ^
--visibility-miles=30 





