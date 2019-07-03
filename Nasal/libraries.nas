# Platypus Libraries
# Joshua Davidson (it0uchpods) adapted by gk
# gdoors ============================================================
rightDoor = aircraft.door.new( "/sim/model/door-positions/rightDoor", 2, 0 );

var checkUse = func () {
	var totalUse = props.globals.getNode("/systems/data/total-use");	
	totalUse.setValue(totalUse.getValue() + 1);
}
	aircraft.data.add(
        "instrumentation/kma20/test",
        "instrumentation/kma20/auto",
        "instrumentation/kma20/com1",
        "instrumentation/kma20/com2",
        "instrumentation/kma20/nav1",
        "instrumentation/kma20/nav2",
        "instrumentation/kma20/adf",
        "instrumentation/kma20/dme",
        "instrumentation/kma20/mkr",
        "instrumentation/kma20/sens",
        "instrumentation/kma20/knob"
        );
		
	
		
#set winter condition

if(getprop("/systems/snow") == 1) {
	setprop("/sim/startup/season","winter");
	setprop("/sim/rendering/clouds3d-enable",1);
	} else {
	setprop("/sim/startup/season","summer");
};

if(getprop("/option/trm") != 5) {
		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));
		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "trim-panel" }));
}

fgcommand("timeofday", props.Node.new({ "timeofday" : "morning" }));
setprop("/sim/menubar/default/menu[9]/item[6]/enabled",1); 

if (getprop("/systems/starts") > 321) {
	setprop("/systems/nbat", 1);
	setprop("/sim/menubar/default/menu[102]/item[4]/enabled", 1);
	setprop("/systems/electrical/batt-volt", 0);
	setprop("/systems/electrical/batt-amp", 0);
} 

if (getprop("/systems/starts") < 321) {
	setprop("/sim/menubar/default/menu[102]/item[4]/enabled", 0);
	setprop("/systems/nbat", 0);
	setprop("/systems/electrical/batt-volt", 12);
	setprop("/systems/electrical/batt-amp", 35);		
}

# reset compass rose rotation for the ki228
setlistener( "/instrumentation/adf[0]/model", func(n) {
  if( n != nil ) {
    var v = n.getValue();
    if( v != nil and v == "ki228" )
      setprop("instrumentation/adf[0]/rotation-deg", 0 );
  }
}, 1, 0 );

gui.Dialog.new("sim/gui/dialogs/windsim/dialog", "Aircraft/FG-Platypus/Dialogs/windsim.xml");
gui.Dialog.new("sim/gui/dialogs/viewBarWarrior_h/dialog", 
"Aircraft/FG-Platypus/Dialogs/viewBarWarrior_h.xml");
gui.Dialog.new("sim/gui/dialogs/Spec/dialog", 
"Aircraft/FG-Platypus/Dialogs/Spec.xml");
gui.Dialog.new("sim/gui/dialogs/immat/dialog", 
"Aircraft/FG-Platypus/Dialogs/immat.xml");
gui.Dialog.new("sim/gui/dialogs/shortcuts/dialog", 
"Aircraft/FG-Platypus/Dialogs/shortcuts.xml");
gui.Dialog.new("sim/gui/dialogs/dpresets/dialog", 
"Aircraft/FG-Platypus/Dialogs/dpresets.xml");
gui.Dialog.new("sim/gui/dialogs/etwatch/dialog", 
"Aircraft/FG-Platypus/Dialogs/etwatch.xml");
gui.Dialog.new("sim/gui/dialogs/eta/dialog", 
"Aircraft/FG-Platypus/Dialogs/eta.xml");
gui.Dialog.new("sim/gui/dialogs/divert/dialog", 
"Aircraft/FG-Platypus/Dialogs/divert.xml");
gui.Dialog.new("sim/gui/dialogs/stats/dialog", 
"Aircraft/FG-Platypus/Dialogs/stats.xml");
gui.Dialog.new("sim/gui/dialogs/dash/dialog", 
"Aircraft/FG-Platypus/Dialogs/dash.xml");
gui.Dialog.new("sim/gui/dialogs/accft/dialog", 
"Aircraft/FG-Platypus/Dialogs/accft.xml");
gui.Dialog.new("sim/gui/dialogs/freq-search/dialog", 
"Aircraft/FG-Platypus/Dialogs/freq-search.xml");
gui.Dialog.new("sim/gui/dialogs/instrumentsAlt/dialog", 
"Aircraft/FG-Platypus/Dialogs/instrumentsAlt.xml");
gui.Dialog.new("sim/gui/dialogs/check1/dialog", 
"Aircraft/FG-Platypus/Dialogs/check1.xml");
gui.Dialog.new("sim/gui/dialogs/check2/dialog", 
"Aircraft/FG-Platypus/Dialogs/check2.xml");
gui.Dialog.new("sim/gui/dialogs/procs/dialog", 
"Aircraft/FG-Platypus/Dialogs/procs.xml");
gui.Dialog.new("sim/gui/dialogs/hdgselect/dialog", 
"Aircraft/FG-Platypus/Dialogs/hdgselect.xml");
gui.Dialog.new("sim/gui/dialogs/qcalc/dialog", 
"Aircraft/FG-Platypus/Dialogs/qcalc.xml");
gui.Dialog.new("sim/gui/dialogs/lifo/dialog", 
"Aircraft/FG-Platypus/Dialogs/lifo.xml");
gui.Dialog.new("sim/gui/dialogs/trim-panel/dialog", 
"Aircraft/FG-Platypus/Dialogs/trim-panel.xml");
gui.Dialog.new("sim/gui/dialogs/location-in-air-pa/dialog", 
"Aircraft/FG-Platypus/Dialogs/location-in-air-pa.xml");
gui.Dialog.new("sim/gui/dialogs/fuelstatus/dialog", 
"Aircraft/FG-Platypus/Dialogs/fuelstatus.xml");
gui.Dialog.new("sim/gui/dialogs/gpsl/dialog", 
"Aircraft/FG-Platypus/Dialogs/gpsl.xml");
gui.Dialog.new("sim/gui/dialogs/napt/dialog", 
"Aircraft/FG-Platypus/Dialogs/napt.xml");
gui.Dialog.new("sim/gui/dialogs/qreset/dialog", 
"Aircraft/FG-Platypus/Dialogs/qreset.xml");
gui.Dialog.new("sim/gui/dialogs/massbal/dialog", 
"Aircraft/FG-Platypus/Dialogs/massbal.xml");
gui.Dialog.new("sim/gui/dialogs/nt1/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt1.xml");
gui.Dialog.new("sim/gui/dialogs/nt2/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt2.xml");
gui.Dialog.new("sim/gui/dialogs/nt3/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt3.xml");
gui.Dialog.new("sim/gui/dialogs/nt4/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt4.xml");
gui.Dialog.new("sim/gui/dialogs/nt5/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt5.xml");
gui.Dialog.new("sim/gui/dialogs/nt6/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt6.xml");
gui.Dialog.new("sim/gui/dialogs/nt7/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt7.xml");
gui.Dialog.new("sim/gui/dialogs/nt8/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt8.xml");
gui.Dialog.new("sim/gui/dialogs/nt9/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt9.xml");
gui.Dialog.new("sim/gui/dialogs/nt10/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt10.xml");
gui.Dialog.new("sim/gui/dialogs/nt11/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt11.xml");
gui.Dialog.new("sim/gui/dialogs/nt12/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt12.xml");
gui.Dialog.new("sim/gui/dialogs/nt13/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt13.xml");
gui.Dialog.new("sim/gui/dialogs/nt14/dialog", 
"Aircraft/FG-Platypus/Dialogs/nt14.xml");
gui.Dialog.new("sim/gui/dialogs/qconv/dialog", 
"Aircraft/FG-Platypus/Dialogs/qconv.xml");
gui.Dialog.new("sim/gui/dialogs/windconfig/dialog", 
"Aircraft/FG-Platypus/Dialogs/windconfig.xml");
gui.Dialog.new("sim/gui/dialogs/speedo/dialog", 
"Aircraft/FG-Platypus/Dialogs/speedo.xml");
gui.Dialog.new("sim/gui/dialogs/instructdiv/dialog", 
"Aircraft/FG-Platypus/Dialogs/instructdiv.xml");
gui.Dialog.new("sim/gui/dialogs/instruct11/dialog", 
"Aircraft/FG-Platypus/Dialogs/instruct11.xml");
gui.Dialog.new("sim/gui/dialogs/seatpos/dialog", 
"Aircraft/FG-Platypus/Dialogs/seatpos.xml");
gui.Dialog.new("sim/gui/dialogs/abort/dialog", 
"Aircraft/FG-Platypus/Dialogs/abort.xml");
gui.Dialog.new("sim/gui/dialogs/hudcolor/dialog", 
"Aircraft/FG-Platypus/Dialogs/hudcolor.xml");
gui.Dialog.new("sim/gui/dialogs/choose/dialog", 
"Aircraft/FG-Platypus/Dialogs/choose.xml");
setprop("/systems/apd",1) ;
setprop("/systems/checklist",1) ;
setprop("/systems/clname","preflight") ;
setprop("/systems/em",1) ;
setprop("/options/trm",18) ;
setprop("/systems/emname","efs") ;
setprop("/sim/current-view/view-number", "0");

	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "etwatch" }));
	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "accft" }));

setlistener("/sim/sounde/switch1", func {
	if (!getprop("/sim/sounde/switch1")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/switch1").setBoolValue(0);
	}, 0.05);
});

setlistener("/sim/sounde/switch2", func {
	if (!getprop("/sim/sounde/switch2")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/switch2").setBoolValue(0);
	}, 0.05);
});

setlistener("/sim/sounde/switch3", func {
	if (!getprop("/sim/sounde/switch3")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/switch3").setBoolValue(0);
	}, 0.05);
});

setlistener("/sim/sounde/knob", func {
	if (!getprop("/sim/sounde/knob")) {
		return;
	}
	settimer(func {
		props.globals.getNode("/sim/sounde/knob").setBoolValue(0);
	}, 0.05);
});

    # Set the altimeter
    var pressure_sea_level = getprop("/environment/pressure-sea-level-inhg");
    setprop("/instrumentation/altimeter/setting-inhg", pressure_sea_level);

    # Set heading offset
    var magnetic_variation = getprop("/environment/magnetic-variation-deg");
    setprop("/instrumentation/heading-indicator/offset-deg", -magnetic_variation);
    setprop("/instrumentation/altimeter/setting-inhg-formatted", int(getprop("/instrumentation/altimeter/setting-inhg")*100.0)/100.0);
	setlistener("/sim/signals/fdm-initialized", func {
	systems.elec_init();
	systems.engine_init();
	systems.fuel_init();
	systems.ospd_init();	
	systems.wdheight_init();
	systems.wdawc_init();
	checkUse();
	print("FDM initialised...");
	itaf.ap_init();

	##libraries.variousReset();

	libraries.seat_pilot_defaults(); 
	#really should reset presets, but buggy

		## flashlight ##

if (getprop("/systems/fl") == 1)  {

	setprop("/sim/rendering/als-secondary-lights/use-flashlight", 1);}

		## toggle auto refuel ##

if (getprop("/systems/autofuel") == 1)  {

	setprop("/consumables/fuel/tank/level-gal_us", 17);
	setprop("/consumables/fuel/tank[1]/level-gal_us", 17);	
	}
	
	#set parameters for quickstart20

if (getprop("/systems/div") == 1) {
		setprop("/options/trm",20);
		setprop("/environment/weather-scenario","Border of a low pressure region");
}	
	
	## fetch Ils data for quickstarts ##

if (getprop("/systems/ils") == 1)  {
	setprop("/sim/presets/runway", (getprop("/sim/atc/runway")));	
	var cur_runway = getprop("sim/presets/runway");
      var runways = airportinfo(getprop("sim/presets/airport-id")).runways;
      var r =runways[cur_runway];
      if (r != nil and r.ils != nil) {
            setprop("instrumentation/nav/frequencies/selected-mhz", (r.ils.frequency / 100));
			setprop("instrumentation/nav/radials/selected-deg", (r.heading));
				var win = screen.window.new(nil, -80, 1, 9);
				win.fg = [1, 1, 1, 1]; 	
				win.align = "left";
				win.write("Nav1 set to ILS Frequency ",0.8,0,0 );
				} else {
				var win = screen.window.new(nil, -80, 1, 9);
				win.fg = [1, 1, 1, 1]; 	
				win.align = "left";
				win.write("Selected Runway has no ILS",0.8,0,0 );
				}	
				setprop("/systems/ils",0);
	}

if (getprop("/systems/autofuel") == 0)  {

	if (getprop("/sim/model/equipment/ground-services/fuel-truck/enable") == 1)  {
		if (getprop("/consumables/fuel/total-fuel-gal_us") < 9)  {

if(getprop("/gear/gear/wow")==1){
	        setprop("/controls/gear/brake-parking", 1); 
 var msgwait_delay = 6.0;
    settimer(func {
        if (getprop("/sim/sceneryloaded")) {
            logger.screen.red("Currently less than 10 gallons of fuel onboard!",7);
        }
        setprop("/systems/tmp1", 0);       
    }, msgwait_delay);
	}
	}
}
} 

	setprop("/systems/iso",1) ;   

	##Takeoff Practise engine running

	if (getprop("/systems/lapa") == 1)  {
		setprop("/sim/presets/running",1);	
		setprop("/controls/electrical/battery", 1);
     	setprop("/controls/electrical/alternator", 1);
		setprop("/controls/switches/avionics-master", 1);
		setprop("/controls/engines/engine[0]/magnetos-switch", 3);
		setprop("/controls/switches/fuel-pump", 1);
		setprop("/controls/engines/engine/throttle", 1);
		setprop("/controls/engines/engine/mixture", 1);
		setprop("/controls/engines/engine/throttle", 0.2);
		setprop("/controls/switches/panel-lights-factor", 1);
		setprop("/controls/switches/nav-lights", 1);
		setprop("/controls/switches/nav-lights-factor", 1);
		setprop("/controls/switches/strobe-lights", 1);	
		setprop("/controls/switches/panel-lights-factor", 1);
		setprop("/environment/weather-scenario", "Fair weather");
		setprop("/systems/iso",0) ;
		setprop("/sim/hud/visibility[1]", 0);

	## get selected runway length
	var a = airportinfo();
		apt = getprop("/sim/presets/airport-id");	
		apt = a;
	var cur_runway = getprop("sim/presets/runway");        
    var runways = airportinfo(getprop("sim/presets/airport-id")).runways;		
	var lg = apt.runways[cur_runway].length;
		setprop("/systems/rwlg",lg/0.304878);
		setprop("/systems/rwlgm",lg);
		    if(getprop("/systems/mws")== 0) {
				fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windconfig" }));
				fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windsim" }));
			} else {
				fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windsim" }));
	};

		fgcommand("dialog-show", props.Node.new({ "dialog-name" : "speedo" }));

if (getprop("/engines/engine/fuel-flow-gph") ==0) {
	var delay = 5;
    	settimer(func {
		gui.popupTip("No RPM - Press s to start engine!
q to hide the properties ", 6);                   
    }, delay);
	}
}

##on ground engine running

if (getprop("/systems/eng") == 1)  {
	setprop("/controls/flight/flaps", 0.0);
	setprop("/controls/flight/elevator-trim", 0);
	setprop("/controls/flight/rudder-trim", 0);	
	setprop("/controls/electrical/battery", 1);
	setprop("/controls/electrical/alternator", 1);
	setprop("/controls/switches/beacon", 1);
	setprop("/controls/switches/strobe-lights", 1);
	setprop("/controls/switches/nav-lights-factor", 1);
	setprop("/controls/switches/avionics-master", 1);
	setprop("/systems/fuel/selected-tank", 1);
	setprop("/controls/engines/engine[0]/mixture", 1);
	setprop("/controls/engines/engine[0]/throttle", 0.3);
	setprop("/controls/engines/engine[0]/magnetos-switch", 4);
	interpolate("/controls/engines/engine[0]/throttle", 0.15, 3);

settimer(func {
		setprop("/controls/engines/engine[0]/magnetos-switch", 3);
		}, 3);

	## get selected runway length
	var a = airportinfo();
		apt = getprop("/sim/presets/airport-id");	
		apt = a;
	var cur_runway = getprop("sim/presets/runway");
        
            var runways = airportinfo(getprop("sim/presets/airport-id")).runways;
		
		var lg = apt.runways[cur_runway].length;

		setprop("/systems/rwlg",lg/0.304878);
		setprop("/systems/rwlgm",lg);
}	

	##set parameters for commandline starts ##
	##options will be run if the batchfile sets the property saloft to 1 ###

	if (getprop("/systems/saloft") == 1)  {
		
	setprop("/controls/electrical/battery", 1);
    setprop("/controls/electrical/alternator", 1);
  	setprop("/controls/switches/avionics-master", 1);
  	setprop("/controls/engines/engine[0]/magnetos-switch", 3);
  	setprop("/controls/switches/fuel-pump", 1);
  	setprop("/controls/engines/engine/throttle", 1);
  	setprop("/controls/engines/engine/mixture", 1);
	setprop("/controls/engines/engine[0]/magnetos-switch", 4);
	setprop("/controls/engines/engine/running", 1);
	setprop("/controls/engines/engine[0]/magnetos-switch", 3);
	setprop("/controls/switches/panel-lights-factor", 1);
	setprop("/controls/switches/nav-lights", 1);
	setprop("/controls/switches/nav-lights-factor", 1);
	setprop("/controls/switches/strobe-lights", 1);	
	setprop("/controls/switches/landing-light", 1);
  	setprop("/controls/switches/panel-lights-factor", 1);
  	setprop("/it-autoflight/input/ap", 1);		
	setprop("/it-autoflight/input/lat", 0);
	setprop("/controls/engines/engine/throttle", 0.80);
	setprop("/controls/engines/engine/starter", 0);
	setprop("/engines/engine/fuel-pressure-psi", 4.3);
	setprop("/options/amx", 1);	
	davtron803.davtron_flight_time.reset();
	davtron803.davtron_flight_time.start();

	if (getprop("/systems/nbat")== 0) {
		var inc = props.globals.getNode("/systems/starts");
		inc.setValue(inc.getValue() + 1);
	}
	if (getprop("/systems/starts") > 321)  {
	logger.screen.red("Electrical systems malfunction,
engine can not start, please restart on the ground
and replace your depleted battery", 3);
	}

		## compass failure ##	
	
	if (getprop("/systems/noco") == 1)  {	
	setprop("/sim/failure-manager/instrumentation/magnetic-compass/mtbf",45);
     setprop("/sim/failure-manager/instrumentation/heading-indicator/mtbf", 60);  	
	}
		## brake failure ##	
	
if (getprop("/systems/lbr") == 1)  {
	
	setprop("/systems/lbr",3);
  	
	}

		## power failure ##

if (getprop("/systems/nopo") == 1)  {

	logger.screen.red("Electrical systems malfunction", 3);
	setprop("/controls/electrical/battery", 0);
     	setprop("/controls/electrical/alternator", 0);
	setprop("/it-autoflight/input/vs",500);
	}

		## engine failure ##

if (getprop("/systems/noen") == 1)  {

	setprop("/sim/failure-manager/engines/engine/mtbf", 60);

	}
		## altimeter failure ##

if (getprop("/systems/noalt") == 1)  {

		setprop("/sim/failure-manager/instrumentation/altimeter/mtbf", 150);
     	setprop("/sim/failure-manager/instrumentation/airspeed-indicator/mtbf", 120);
	setprop("/controls/engines/engine/throttle",0.75);

	}
		## combined nav failure##

if (getprop("/systems/nonav1") == 1)  {

		setprop("/sim/failure-manager/instrumentation/nav/cdi/mtbf", 75);
		setprop("/sim/failure-manager/instrumentation/nav/gs/mtbf", 75);     
	}

if (getprop("/systems/nonav1") == 0)  {

		setprop("/sim/failure-manager/instrumentation/nav/cdi/serviceable", 1);
		setprop("/sim/failure-manager/instrumentation/nav/gs/serviceable", 1);     
	}

if (getprop("/systems/nonav2") == 1)  {
		setprop("/sim/failure-manager/instrumentation/nav[1]/cdi/mtbf", 100);
     	setprop("/sim/failure-manager/instrumentation/nav[1]/gs/mtbf", 100);
	}

if (getprop("/systems/nonav2") == 0)  {
		setprop("/sim/failure-manager/instrumentation/nav[1]/cdi/serviceable", 1);
     	setprop("/sim/failure-manager/instrumentation/nav[1]/gs/serviceable", 1);
	}

		## cloud ceiling##

if (getprop("/systems/soup") == 1)  {
	setprop("/environment/weather-scenario", "CAT II minimum");	
	}
		## nav settings##

if (getprop("/systems/proc") == 1)  {
	setprop("/instrumentation/nav/frequencies/selected-mhz",110.9);
    setprop("/instrumentation/nav/radials/selected-deg", 258);	
	}

if (getprop("/systems/starts") < 321)  {

if (getprop("/sim/freeze/clock")== 1) {
	logger.screen.red("Set relevant parameters and press p to continue.",4);
	}
	}
}
    var autopilot = gui.Dialog.new("sim/gui/dialogs/autopilot/dialog", "Aircraft/FG-Platypus/Systems/kap140-dlg.xml");
	setprop("/it-autoflight/input/hdg", getprop("/orientation/heading-magnetic-deg"));
	setprop("/environment/weather-scenario", "Core high pressure region");
	setprop("/it-autoflight/input/alt", 2500);
	setprop("/it-autoflight/settings/slave-gps-nav", 0);
    setprop("engines/engine[0]/fuel-flow-gph", 0.0);
    setprop("/surface-positions/flap-pos-norm", 0.0);
    setprop("/instrumentation/airspeed-indicator/indicated-speed-kt", 0.0);
    setprop("/instrumentation/airspeed-indicator/pressure-alt-offset-deg", 0.0);
    setprop("/instrumentation/transponder/inputs/knob-mode", 5);
    setprop("/accelerations/pilot-g", 1.0);
    setprop("/sim/model/material/LandingLight/factor", 0.0);
    setprop("/sim/rendering/lightning-enable", 1);	
    setprop("/environment/config/presets/wind-override", 0); 
	setprop("/sim/model/material/LandingLight/factorAGL", 0.0); 
    setprop("/instrumentation/dme/volume", 1);
    setprop("/instrumentation/nav/volume", 1); 
    setprop("/instrumentation/nav[1]/volume", 1); 
	setprop("/instrumentation/davtron803/top-mode","C");
    setprop("/instrumentation/davtron803/bot-mode", "UT");
	fgcommand("dialog-close", props.Node.new({ "dialog-name" : "check2" }));	
}); 

var inc = props.globals.getNode("/systems/starts");
	inc.setValue(inc.getValue() + 1);

var variousReset = func {
	setprop("/it-autoflight/input/hdg", getprop("/orientation/heading-magnetic-deg"));
	setprop("/it-autoflight/input/alt", 2000);
	setprop("/it-autoflight/settings/slave-gps-nav", 0);
	setprop("/controls/switches/beacon", 0);
	setprop("/controls/switches/fuel-pump", 0);
	setprop("/controls/switches/landing-light", 0);
	setprop("/controls/switches/nav-lights-factor", 0);
	setprop("/controls/switches/panel-lights-factor", 0);
	setprop("/controls/switches/pitot-heat", 0);
	setprop("/controls/electric/battery", 0);
	setprop("/controls/switches/strobe-lights", 0);
	setprop("/controls/engines/engine[0]/magnetos-switch", 0);
	setprop("/controls/engines/engine[0]/mixture", 0);
	setprop("/fdm/jsbsim/extra/door-main-cmd", 0);
	setprop("/instrumentation/transponder/id-code", 3158);
}

setlistener("/options/nav-source", func {
	if (getprop("/options/nav-source") == 1) {
		setprop("/it-autoflight/settings/use-nav2-radio", 0);
		setprop("/it-autoflight/settings/slave-gps-nav", 0);
	} else if (getprop("/options/nav-source") == 2) {
		setprop("/it-autoflight/settings/use-nav2-radio", 0);
		setprop("/it-autoflight/settings/slave-gps-nav", 1);
	} else if (getprop("/options/nav-source") == 3) {
		setprop("/it-autoflight/settings/use-nav2-radio", 1);
		setprop("/it-autoflight/settings/slave-gps-nav", 0);
	}
});

if (getprop("/controls/flight/auto-coordination") == 1) {
	setprop("/controls/flight/auto-coordination", 1);
	setprop("/controls/flight/aileron-drives-tiller", 0);
} else {
	setprop("/controls/flight/aileron-drives-tiller", 0);
}

if (getprop("/systems/starts") > 321) {
	setprop("/systems/nbat", 1);
	setprop("/systems/electrical/batt-volt", 0);
	setprop("/systems/electrical/batt-amp", 0);
} else {
		setprop("/systems/nbat", 0);
		setprop("/systems/electrical/batt-volt", 12);
		setprop("/systems/electrical/batt-amp", 35);
}

var statsreset = func {
	setprop("/systems/data/acc-flight-secs",0);
	setprop("/systems/data/cra",0);
	setprop("/systems/data/rip",0);
	setprop("/systems/data/landings",0);
	setprop("/systems/data/aborted",0);
	setprop("/systems/data/lost",0);
     	setprop("/systems/data/nof",0);
	setprop("/systems/data/takeoffs",0);
	setprop("/systems/data/tof",0);
	setprop("/systems/data/total-use",1);	
	logger.screen.red("Flight History and Hobbs have been reset !",1); 
    fgcommand("dialog-close", props.Node.new({ "dialog-name" : "stats" }));     	
}

var aborted = func {
	var tu = getprop("/systems/data/total-use");
	var to = getprop("/systems/data/takeoffs");
	var ab = tu - to ;
	setprop("/systems/data/aborted", ab );	
}

var lost = func {
	var ld = getprop("/systems/data/landings");
	var to = getprop("/systems/data/takeoffs");
	var lo = to - ld;	
	setprop("/systems/data/lost", lo);
}

var inair = func {
	if (getprop("/gear/gear/wow") == 0) {			
		var tc = getprop("/instrumentation/davtron803/flight-time-secs");
		var ac = getprop("/systems/data/acc-flight-secs");
		var up = tc + ac;
		setprop("/systems/data/acc-flight-secs", up);	
			if (getprop("/sim/time/sun-angle-rad") > 1.57)  {
				setprop("/sim/rendering/als-secondary-lights/use-flashlight", 1);	
			}
	}}

##########################################
# Put the weights into the fuel dialog
##########################################
        var limits = props.globals.getNode("/limits/mass-and-balance");
    var ac_limits = props.globals.getNode("/limits/mass-and-balance");

    # Get the mass limits of the current engine
    var ramp_mass = limits.getNode("maximum-ramp-mass-lbs");
    var takeoff_mass = limits.getNode("maximum-takeoff-mass-lbs");
    var landing_mass = limits.getNode("maximum-landing-mass-lbs");

    # Get the actual mass limit nodes of the aircraft
    var ac_ramp_mass = ac_limits.getNode("maximum-ramp-mass-lbs");
    var ac_takeoff_mass = ac_limits.getNode("maximum-takeoff-mass-lbs");
    var ac_landing_mass = ac_limits.getNode("maximum-landing-mass-lbs");

    # Set the mass limits of the aircraft
    ac_ramp_mass.unalias();
    ac_takeoff_mass.unalias();
    ac_landing_mass.unalias();

var sbc1 = aircraft.light.new( "sim/model/lights/sbc1", [0.5, 0.3] );
sbc1.interval = 0.1;
sbc1.switch( 1 );

var sbc2 = aircraft.light.new( "sim/model/lights/sbc2", [0.2, 0.3], "sim/model/lights/sbc1/state" );
sbc2.interval = 0;
sbc2.switch( 1 );

setlistener( "sim/model/lights/sbc2/state", func(n) {
  var bsbc1 = sbc1.stateN.getValue();
  var bsbc2 = n.getBoolValue();
  var b = 0;
  if( bsbc1 and bsbc2 and getprop( "controls/lighting/beacon") ) {
    b = 1;
  } else {
    b = 0;
  }
  setprop( "sim/model/lights/beacon/enabled", b );

  if( bsbc1 and !bsbc2 and getprop( "controls/lighting/strobe" ) ) {
    b = 1;
  } else {
    b = 0;
  }
  setprop( "sim/model/lights/strobe/enabled", b );
});

var beacon = aircraft.light.new( "sim/model/lights/beacon", [0.05, 0.05] );
beacon.interval = 0;

var strobe = aircraft.light.new( "sim/model/lights/strobe", [0.05, 0.05] );
strobe.interval = 0;    
toggle_strobe= func {
toggle=getprop("controls/switches/strobe-lights");
toggle=1-toggle;
setprop("controls/switches/strobe-lights",toggle);
}

## lookup atis on change of ap 	
if (getprop("/systems/eap")==1) {	
		
var airport = airportinfo(getprop("sim/presets/airport-id"));
var atis = airport.comms('atis');
if (!size(atis))
    atis = airport.comms('awos');
if (size(atis)== 0){
		print ("no atis data found, comm1 set to 111.1");			
		setprop("/instrumentation/comm/frequencies/selected-mhz", 111.11);
		} else {	
	printf('%s %.2f', airport.id, size(atis) ? atis[0] : 'Not found');
	setprop("/systems/catis",atis[0]);
	setprop("/instrumentation/comm/frequencies/selected-mhz", (getprop("/systems/catis")));	
}
}	

##
#gross weight exceeding max takeoff weight
##
setlistener("/controls/gear/brake-parking", func {

var grw = getprop("/fdm/jsbsim/inertia/weight-lbs") ;
var tow = getprop("/limits/mass-and-balance/maximum-takeoff-mass-lbs");
		
		if (grw > tow) {
			setprop("/systems/ow",1);		
			if (getprop("/systems/ow") == 1)  {		
		            logger.screen.red("EXCEEDING maximum takeoff weight - 
delay takeoff until you have shed some weight !",9);
			}
					setprop("/systems/ow",0);	
}});

##display props on screen for takeoff qs
	
var tako = screen.display.new(10,-30);

var showtaco = func() {
	
	tako.setcolor(0,0,0);
	tako.format = "%.5g";
 	tako.add("/environment/temperature-degc");
 	tako.add("/position/altitude-ft");
 	tako.add("/position/altitude-agl-ft");
 	tako.add("/position/altitude-agl-ft");
	tako.add("/orientation/heading-deg");
	tako.add("/velocities/airspeed-kt");
	tako.add("/orientation/pitch-deg");
	tako.add("/orientation/roll-deg");
     tako.add("/velocities/vertical-speed-fps");
     tako.add("/environment/wind-from-heading-deg");
     tako.add("/environment/wind-speed-kt");
     tako.add("/orientation/alpha-deg");
}
var closetako = func { tako.close(); }

		setprop("/systems/np",1) ;

##display closest ap info on screen
	
var nap = screen.display.new(410,-130);
var shownap = func() {
	if (getprop("/sim/time/sun-angle-rad") > 1.57)  {
			nap.setcolor(1,0.8,0);	
	}
	if (getprop("/sim/time/sun-angle-rad") < 1.57)  {
			nap.setcolor(1,0,0);	
	}
	nap.format = "%.5g";
 	nap.add("/tracking/airport");
	nap.add("/tracking/distance-nm");
	nap.add("/tracking/course");
	nap.add("/tracking/elevation-ft");
	nap.add("/tracking/longitude");
     	nap.add("/tracking/latitude");
     nap.add("/tracking/lgst_rw");
     
}
var closenap = func { nap.close(); }

##toggle ap props on off via button

var apn = func() {
	if (getprop("/systems/np")== 1 ) {
		libraries.shownap();		
			setprop("/sim/atc/freq-airport", (getprop("/sim/airport/closest-airport-id")));	
			##fgcommand("dialog-show", props.Node.new({ "dialog-name" : "freq-search" }));			
		setprop("/systems/np",0) ;
	    } else {
		libraries.nap.close();
		setprop("/systems/np",1) ;
}}

##toggle props on off via key

var swt = func() {
	if (getprop("/systems/iso")== 1 ) {
		libraries.showtaco();
		setprop("/systems/iso",0) ;
	    } else {
		libraries.tako.close();
		setprop("/systems/iso",1) ;

}}

###setup quickstart for fire
	if (getprop("/systems/fas")== 1 ) {
		setprop("/systems/starts",200) ;
	}

##toggle itaf on off

var ita = func() {
	if (getprop("/systems/apd")== 1 ) {
	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "autopilot" }));
		setprop("/systems/apd",0) ;
	    } else {
	fgcommand("dialog-close", props.Node.new({ "dialog-name" : "autopilot" }));
		setprop("/systems/apd",1) ;
	
}}

#=============
#possible use to restart landing/takoff quickstarts
# Usage:  aircraft.teleport(lat:48.3, lon:32.4, alt:5000);
#
var teleport = func(airport = "", runway = "", lat = -9999, lon = -9999, alt = 0,
		speed = 0, distance = 0, azimuth = 0, glideslope = 0, heading = 9999) {
	setprop("/sim/presets/airport-id", airport);
	setprop("/sim/presets/runway", runway);
	setprop("/sim/presets/parkpos", "");
	setprop("/sim/presets/latitude-deg", lat);
	setprop("/sim/presets/longitude-deg", lon);
	setprop("/sim/presets/altitude-ft", alt);
	setprop("/sim/presets/airspeed-kt", speed);
	setprop("/sim/presets/offset-distance-nm", distance);
	setprop("/sim/presets/offset-azimuth-nm", azimuth);
	setprop("/sim/presets/glideslope-deg", glideslope);
	setprop("/sim/presets/heading-deg", heading);
	setprop("/systems/lapa", 1);
	setprop("/controls/gear/brake-parking", 1);
    	fgcommand("reposition");
}

##########
# function to clean up stuff between nav scenarios
##################################################

var cleanup = func {
	setprop("/systems/mws",0);
	setprop("/systems/dev",0);
	setprop("/systems/div",0);
	setprop("/it-autoflight/input/vs", 0);
	setprop("/controls/electrical/battery", 0);
    setprop("/controls/electrical/alternator", 0);
	setprop("/controls/engines/engine/magnetos", 0);
    setprop("/controls/switches/avionics-master", 0);
	setprop("/options/trm", 20);
	setprop("/sim/current-view/view-number", "0");
	setprop("/sim/failure-manager/controls/flight/flaps/failure-level", 0);
	setprop("/sim/failure-manager/controls/flight/flaps/mtbf", "0");
	setprop("/sim/failure-manager/controls/flight/elevator/failure-level", 0);
	setprop("/sim/failure-manager/controls/flight/elevator/mtbf", "0");
	setprop("/sim/failure-manager/controls/flight/rudder/failure-level", 0);
	setprop("/sim/failure-manager/controls/flight/rudder/mtbf", 0);
	setprop("/sim/failure-manager/engines/engine/failure-level", 0);
	setprop("/sim/failure-manager/engines/engine/mtbf", 0);
	setprop("/autopilot/route-manager/active", 0);
	setprop("/controls/engines/engine/throttle", 0);
	setprop("/controls/engines/engine/mixture", 0);
	setprop("/hazards/fire/engine", 0);
	setprop("/sim/rendering/als-secondary-lights/use-flashlight", 0);
	davtron803.davtron_flight_time.reset();
			setprop("/environment/weather-scenario", "Core high pressure region");
			setprop("/systems/lapa", 0);
			setprop("/systems/soup", 0);
			setprop("/systems/fl", 0);
			setprop("/systems/flp", 0);
		tako.close();
				fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));
			    fgcommand("dialog-close", props.Node.new({ "dialog-name" : "lifo" }));
				fgcommand("dialog-close", props.Node.new({ "dialog-name" : "check1" }));
				fgcommand("dialog-close", props.Node.new({ "dialog-name" : "check2" }));
				fgcommand("dialog-close", props.Node.new({ "dialog-name" : "trim-panel" }));
				fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));
				fgcommand("dialog-close", props.Node.new({ "dialog-name" : "speedo" }));
	setprop("/sim/freeze/clock",0);
	fgcommand("timeofday", props.Node.new({ "timeofday" : "afternoon" }));
	setprop("/it-autoflight/input/ap", 0);		
	setprop("/it-autoflight/input/lat", 0);
	setprop("/controls/engines/engine/throttle", 0.00);
	setprop("/controls/engines/engine/starter", 0);
	setprop("/controls/engines/engine/mixture", 0.00);
	setprop("/payload/weight/weight-lb",160);
	setprop("/payload/weight[1]/weight-lb",160);
	setprop("/payload/weight[2]/weight-lb",150);
	setprop("/payload/weight[3]/weight-lb",150);
	setprop("/payload/weight[4]/weight-lb",76);
	setprop("/consumables/fuel/tank/level-gal_us",15);
	setprop("/consumables/fuel/tank[1]/level-gal_us",17);
}
		
#waypoint alerts

setprop("autopilot/route-manager/wp[0]/id", 'la' );
setprop("autopilot/route-manager/wp[0]/dist", 0);
setprop("autopilot/route-manager/wp[0]/eta-seconds", 0);
setlistener("/autopilot/route-manager/wp[0]/dist", func {

if (getprop("/options/alerter") ==1 ) {	

	if (getprop("/autopilot/route-manager/wp[0]/dist") < 2.1 ) {
	
	if (getprop("/autopilot/route-manager/wp[0]/eta-seconds") >45 ) {

var waypt = getprop("/autopilot/route-manager/wp[0]/id");
	var arri = getprop("/autopilot/route-manager/wp[0]/eta-seconds");
	var nms = int(getprop("/autopilot/route-manager/wp[0]/dist"));
	gui.popupTip("About " ~ arri ~ " seconds  short of  " ~ waypt , 2); 
		}
		}
	}
});

####
# Fix for the start in air dialog
########

var alof = func() {
	setprop("/systems/bp", 1);
	setprop("/systems/saloft", 1);	
	setprop("/controls/electrical/battery", 1);
    setprop("/controls/electrical/alternator", 1);
  	setprop("/controls/switches/avionics-master", 1);
  	setprop("/controls/engines/engine[0]/magnetos-switch", 3);
  	setprop("/controls/switches/fuel-pump", 1);
	setprop("/engines/engine/fuel-pressure-psi", 4.3);
  	setprop("/controls/engines/engine/throttle", 1);
  	setprop("/controls/engines/engine/mixture", 1);
	setprop("/controls/engines/engine[0]/magnetos-switch", 4);	
  	setprop("/controls/engines/engine/throttle", 0.1);
	setprop("/controls/switches/panel-lights-factor", 1);
	setprop("/controls/switches/nav-lights", 1);
	setprop("/controls/switches/nav-lights-factor", 1);
	setprop("/controls/switches/strobe-lights", 1);	
  	setprop("/controls/switches/panel-lights-factor", 1);
	setprop("/environment/weather-scenario", "Fair weather");
	setprop("/it-autoflight/input/ap", 1);
	setprop("/controls/gear/brake-parking", 0);		
	setprop("/it-autoflight/input/lat", 0);
	setprop("/sim/freeze/clock", 1);
}

#
#fuel alert 
#
setlistener("/systems/freach", func {

if (getprop("/options/nfa") == 1){
	if (getprop("/systems/nfa") != 0){
		if (getprop("/gear/gear/wow") == 0 ) {
			
			if (getprop("/position/altitude-agl-ft") > 1000 ) {

		if (getprop("/systems/freach") < 75) {
			    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "fuelstatus" }));		

			var wpe = screen.window.new(nil, -130, 2, 1);
     wpe.fg = [1, 1, 1, 1];    
     wpe.align = "center";
     wpe.write("Press Del to stop automatic alert", 1, 0, 0);
     	wpe.write("Check GPS for airports in range", 0, 0, 1);
			}
			if (getprop("/systems/nfa") == 0){
					fgcommand("dialog-close", props.Node.new({ "dialog-name" : "fuelstatus" }));
					} 
			}
		}
	}
}	
});

##
#  fail eng at 4200 ft for scenario and test auto mix
##

setlistener("/instrumentation/altimeter/indicated-altitude-ft", func {
	if (getprop("/instrumentation/altimeter/indicated-altitude-ft") > 4000 and getprop("/systems/au") ==1) {

setprop("/sim/failure-manager/engines/engine/mtbf", 5);
	}
	if (getprop("/instrumentation/altimeter/indicated-altitude-ft") > 2700 and getprop("/systems/flp") ==1) {

setprop("/sim/failure-manager/controls/flight/flaps/failure-level", 1);

}});

var val = 0;
var test = 0;
var toggle = 0;

var fuel_switch = func {
  node = props.globals.getNode("consumables/fuel/tank[0]/selected",0);
  node.setBoolValue(0);
  node = props.globals.getNode("consumables/fuel/tank[1]/selected",0);
  node.setBoolValue(0);

  val = getprop("systems/fuel/selected-tank");
  test = 1 + val;
  if(test > 2){test=0};
  setprop("systems/fuel/selected-tank",test);
  if(test == 1){
    node = props.globals.getNode("consumables/fuel/tank[0]/selected",0);
    node.setBoolValue(1);
    if(getprop("consumables/fuel/tank[0]/level-gal_us")>0.01){
      node = props.globals.getNode("engines/engine/out-of-fuel",1);
      node.setBoolValue(0);
    } 
  }
  if(test == 2){
    node = props.globals.getNode("consumables/fuel/tank[1]/selected",0);
    node.setBoolValue(1);
    if(getprop("consumables/fuel/tank[1]/level-gal_us")>0.01){
      node = props.globals.getNode("engines/engine/out-of-fuel",1);
      node.setBoolValue(0);
    } 
  }
}
