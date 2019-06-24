
set /p la=Latitude:
set /p lo=Longitude:
set /p al=Altitude:
set /p of=Heading:
set /p sp=Airspeed:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--lon=%lo% ^
--lat=%la% ^
--altitude=%al% ^
--heading=%of% ^
--timeofday=afternoon ^
--language=en ^
--prop:/systems/saloft=1 ^
--prop:/systems/bp=1 ^
--prop:/systems/nora=1 ^
--aircraft=FG-Platypus-180 ^
--in-air ^
--prop:/controls/gear/brake-parking=0 ^
--prop:/controls/electrical/battery=true ^
--prop:/controls/electrical/alternator=true ^
--prop:/controls/switches/avionics-master=1 ^
--prop:/controls/engines/engine[0]/magnetos-switch=4 ^
--prop:/controls/engines/engine/mixture=1 ^
--prop:/controls/engines/engine/throttle=0.7 ^
--prop:/controls/engines/engine/running=true ^
--prop:/engines/engine[0]/rpm=2100 ^
--vc=%sp% ^
--geometry=800x600 ^
--enable-auto-coordination ^
--disable-real-weather-fetch ^
--disable-ai-models ^
--disable-terrasync ^
--disable-ai-traffic ^
--disable-hud-3d ^
--visibility-miles=30 ^
--enable-freeze




