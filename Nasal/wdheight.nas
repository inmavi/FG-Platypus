# PA28-161 Decision Height Alert
# Copyright (c) 2018 Gerhard Kick

#############
# Init Vars for qnh alerts and auto-mixture
#############

setprop("/systems/nm", 0);

setlistener("/sim/signals/fdm-initialized", func {
	var buf = getprop("/systems/walt");
	var adh = getprop("/instrumentation/radar-altimeter/decision-height");
	var cag = getprop("/position/altitude-agl-ft");
	var pag = getprop("/instrumentation/altimeter/indicated-altitude-ft");

});

var wdheight_init = func {
	setprop("/systems/nm", 0);
	wdheight_timer.start();

}

##################
# Main Loop #
##################

var master_wdheight = func {
	buf = getprop("/systems/walt");
	cag = getprop("/position/altitude-agl-ft");
	adh = getprop("/instrumentation/radar-altimeter/decision-height");
	var pag = getprop("/instrumentation/altimeter/indicated-altitude-ft");


		if (getprop("/options/qnh")== 1) {

		if (getprop("/instrumentation/altimeter/setting-inhg-formatted") != 29.92 and getprop("/position/altitude-agl-ft") > 7000){
	setprop("/instrumentation/altimeter/setting-inhg-formatted",29.92);

gui.popupTip("Altimeter now set to 29.92 HG standard MSL, reset prior to approach..",3);

		
	}
	}

		if (getprop("/options/amx")== 1) {

		if (getprop("/autopilot/route-manager/airborne")==1){

			if (pag > 0 and pag < 5000)  {
	setprop("/controls/engines/engine/mixture", 1);
	}
		if (pag > 5000 and pag < 6001)  {

	setprop("/controls/engines/engine/mixture", 0.96)
	}
		if (pag > 6001 and pag < 7001)  {

	setprop("/controls/engines/engine/mixture", 0.85)
	}
		if (pag > 7001 and pag < 8001)  {

	setprop("/controls/engines/engine/mixture", 0.8)
	}
		if (pag > 8001 and pag < 9001)  {

	setprop("/controls/engines/engine/mixture", 0.77)
	}
		if (pag > 9001 and pag < 11001)  {

	setprop("/controls/engines/engine/mixture", 0.66)
	}
	
	}
	}
	 	if (getprop("/instrumentation/vertical-speed-indicator/indicated-speed-fpm") < -25 and getprop("/options/qnh")== 1) { 
		if (cag > 4990 and cag < 4995)  {
			
 gui.popupTip("Alert: Check ATIS for QNH or runway elevation to reset Altimeter, press a for Airport Info", 4);


	}
	}


	if (cag<=buf)  {

	 	if (getprop("/instrumentation/vertical-speed-indicator/indicated-speed-fpm") < -25 and getprop("/gear/gear/wow")== 0) { 
		if (getprop("/systems/nm") != 1) {
			setprop("/systems/nm", 1);
		}
	 	} 
	} else {
		if (adh<cag) {
			setprop("/systems/nm", 0);
		}
	}
}





setlistener("/systems/nm", func {
	if (getprop("/systems/nm") == 1)  {
	
            gui.popupTip("Alert: Approaching DH , continue or initiate missed approach procedure...", 3);


					
	}
});

###################
# Update Function #
###################

var update_wdheight = func {
	master_wdheight();
}

var wdheight_timer = maketimer(0.1, update_wdheight);





