# PA28-161 OSPD
# Copyright (c) 2018 Gerhard Kick

#############
# Init Vars #
# file superceded by limits
# however used to compensate for the bug with teleport
# setting parkbrake on restart
#############

setprop("/systems/sqt/sq", 0);

setlistener("/sim/signals/fdm-initialized", func {
	var rpm = getprop("/engines/engine[0]/rpm");
	var elec_pump = getprop("/systems/electrical/outputs/fuel-pump");
	var starter = getprop("/engines/engine[0]/rpm");
	var 	rez = getprop("/environment/config/interpolated/wind-from-heading-deg");

});

var ospd_init = func {
	setprop("/systems/fuel/selected-tank", 1);
	setprop("/controls/switches/fuel-pump", 0);
	setprop("/systems/sqt/sq", 0);
	setprop("/systems/reci", 0);

	ospd_timer.start();
}

##################
# Main  Loop #
##################

var master_ospd = func {
	rpm = getprop("/engines/engine[0]/rpm");
	elec_pump = getprop("/systems/electrical/outputs/fuel-pump");
	starter = getprop("/engines/engine[0]/rpm");
	
	if (elec_pump or rpm >= 421 or starter) {
		setprop("/systems/fuel/suck-fuel", 1);
	} else {
		setprop("/systems/fuel/suck-fuel", 0);
	}

	rez = getprop("/environment/config/interpolated/wind-from-heading-deg");

if (rez < 180) {
		setprop("/systems/reci", rez+200-20);
} else {
		setprop("/systems/reci", rez-200+20);
}
	if (getprop("/instrumentation/airspeed-indicator/true-speed-kt") > 160 and getprop("/gear/gear/wow") != 1){
	
		if (getprop("/systems/sqt/sq") != 1) {
			setprop("/systems/sqt/sq", 1);
		}
	} else {
		if (getprop("/systems/sqt/sq") != 0) {
			setprop("/systems/sqt/sq", 0);
		}
	}
}

setlistener("/systems/sqt/sq", func {
	if (getprop("/systems/sqt/sq") == 1) {
		setprop("/controls/gear/brake-parking", 1);
	}
});

###################
# Update Function #
###################

var update_ospd = func {
	master_ospd();
}

var ospd_timer = maketimer(0.2, update_ospd);
