# PA28-161 Fuel
# Copyright (c) 2017 Joshua Davidson (it0uchpods)

#############
# Init Vars #
#############

setprop("/systems/fuel/low-fuel", 0);


setlistener("/sim/signals/fdm-initialized", func {
	var rpm = getprop("/engines/engine[0]/rpm");
	var elec_pump = getprop("/systems/electrical/outputs/fuel-pump");
	var starter = getprop("/engines/engine[0]/rpm");
});

var fuel_init = func {
	setprop("/systems/fuel/selected-tank", 1);
	setprop("/controls/switches/fuel-pump", 0);
	fuel_timer.start();
}

##################
# Main Fuel Loop #
##################

var master_fuel = func {
	rpm = getprop("/engines/engine[0]/rpm");
	elec_pump = getprop("/systems/electrical/outputs/fuel-pump");
	starter = getprop("/engines/engine[0]/rpm");
	
	if (elec_pump or rpm >= 421 or starter) {
		setprop("/systems/fuel/suck-fuel", 1);
	} else {
		setprop("/systems/fuel/suck-fuel", 0);
	}

	if (getprop("/consumables/fuel/tank/level-gal_us") < 0.3 and getprop("/systems/orf") == 0 )  {
		setprop("/consumables/fuel/tank/level-gal_us",1) ;
		}
   if (getprop("/consumables/fuel/tank/level-gal_us") < 0.3 and getprop("/systems/orf") == 1 )  {

		setprop("/controls/fuel-selector",2) ;
		setprop("/systems/fuel/selected-tank",2) ;
		setprop("/systems/fuel/selected-tank-knb",2) ;
	}
	
	if (getprop("/consumables/fuel/total-fuel-gal_us") < 3) {
		if (getprop("/systems/fuel/low-fuel") != 1) {
			setprop("/systems/fuel/low-fuel", 1);
		}
	} else {
		if (getprop("/systems/fuel/low-fuel") != 0) {
			setprop("/systems/fuel/low-fuel", 0);
		}
	}
}

setlistener("/systems/fuel/low-fuel", func {
	if (getprop("/systems/fuel/low-fuel") == 1) {
		if(getprop("/options/nfa")) {
		if (getprop("/position/altitude-agl-ft") > 100) {
		gui.popupTip("Warning, LOW FUEL!!",4);		
		setprop("/instrumentation/transponder/id-code", 7700);
	setprop("/systems/data/nof", getprop("/systems/data/nof") + 1);
	}
	}
}
	
});

###################
# Update Function #
###################

var update_fuel = func {
	master_fuel();
}

var fuel_timer = maketimer(0.2, update_fuel);
