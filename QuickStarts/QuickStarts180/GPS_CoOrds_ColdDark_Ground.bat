
set /p la=Latitude:
set /p lo=Longitude:
set /p or=Heading:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--lon=%lo% ^
--lat=%la% ^
--heading=%or% ^
--timeofday=afternoon ^
--language=en ^
--prop:/systems/saloft=0 ^
--prop:/systems/bp=1 ^
--prop:/systems/nora=1 ^
--aircraft=WarriorII-180 ^
--geometry=800x600 ^
--enable-auto-coordination ^
--disable-real-weather-fetch ^
--disable-ai-models ^
--disable-terrasync ^
--disable-ai-traffic ^
--disable-hud-3d ^
--visibility-miles=30 





