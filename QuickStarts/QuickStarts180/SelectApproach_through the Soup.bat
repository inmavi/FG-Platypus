
set /p ap=Airport:
set /p rw=Runway:
set /p al=Altitude:
set /p of=Distance:

"D:\FlightGear 2018.3.2\bin\fgfs.exe" --fg-root="D:\FlightGear 2018.3.2\data" ^
--airport=%ap% ^
--runway=%rw% ^
--altitude=%al% ^
--offset-distance=%of% ^
--timeofday=afternoon ^
--language=en ^
--prop:/systems/saloft=1 ^
--prop:/systems/bp=1 ^
--prop:/systems/ils=1 ^
--prop:/systems/nora=1 ^
--prop:/systems/soup=1 ^
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
--vc=115 ^
--geometry=800x600 ^
--enable-auto-coordination ^
--disable-real-weather-fetch ^
--disable-ai-models ^
--disable-terrasync ^
--disable-ai-traffic ^
--disable-hud-3d ^
--visibility-miles=15 ^
--enable-freeze




