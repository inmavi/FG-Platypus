# Aircraft Config Center g
# Joshua Davidson (it0uchpods)

# Copyright (c) 2017 Joshua Davidson (it0uchpods)
# mods GK
var spinning = maketimer(0.05, func {
	var spinning = getprop("/systems/acconfig/spinning");
	if (spinning == 0) {
		setprop("/systems/acconfig/spin", "\\");
		setprop("/systems/acconfig/spinning", 1);
	} else if (spinning == 1) {
		setprop("/systems/acconfig/spin", "|");
		setprop("/systems/acconfig/spinning", 2);
	} else if (spinning == 2) {
		setprop("/systems/acconfig/spin", "/");
		setprop("/systems/acconfig/spinning", 3);
	} else if (spinning == 3) {
		setprop("/systems/acconfig/spin", "-");
		setprop("/systems/acconfig/spinning", 0);
	}
});

setprop("/systems/acconfig/autoconfig-running", 0);
setprop("/systems/acconfig/spinning", 0);
setprop("/systems/acconfig/spin", "-");
setprop("/systems/acconfig/new-revision", "");
setprop("/systems/acconfig/out-of-date", 0);


var main_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/main/dialog", "Aircraft/FG-Platypus/AircraftConfig/main.xml");
var welcome_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/welcome/dialog", "Aircraft/FG-Platypus/AircraftConfig/welcome.xml");
var ps_load_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/psload/dialog", "Aircraft/FG-Platypus/AircraftConfig/psload.xml");
var ps_loaded_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/psloaded/dialog", "Aircraft/FG-Platypus/AircraftConfig/psloaded.xml");
var ps_loaded_ns_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/psloaded_ns/dialog", "Aircraft/FG-Platypus/AircraftConfig/psloaded_ns.xml");
var init_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/init/dialog", "Aircraft/FG-Platypus/AircraftConfig/ac_init.xml");
var help_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/help/dialog", "Aircraft/FG-Platypus/AircraftConfig/help.xml");
var about_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/about/dialog", "Aircraft/FG-Platypus/AircraftConfig/about.xml");
var minipanel_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/minipanel/dialog", "Aircraft/FG-Platypus/AircraftConfig/mini-panel.xml");
var update_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/update/dialog", "Aircraft/FG-Platypus/AircraftConfig/update.xml");
gui.Dialog.new("sim/gui/dialogs/etwatch/dialog", 
"Aircraft/FG-Platypus/Dialogs/etwatch.xml");
gui.Dialog.new("sim/gui/dialogs/eta/dialog", 
"Aircraft/FG-Platypus/Dialogs/eta.xml");
gui.Dialog.new("sim/gui/dialogs/accft/dialog", 
"Aircraft/FG-Platypus/Dialogs/accft.xml");
gui.Dialog.new("sim/gui/dialogs/instrumentsAlt/dialog", 
"Aircraft/FG-Platypus/Dialogs/instrumentsAlt.xml");


####disable acconfig for commandline starts####


if (getprop("/systems/bp") == 0 and getprop("/systems/welcome-enabled") == 1) {
		spinning.start();
		init_dlg.open();
}




setlistener("/sim/signals/fdm-initialized", func {
		if (getprop("/systems/bp") == 0 and getprop("/systems/welcome-enabled") == 1) {

	init_dlg.close();
	welcome_dlg.open();	
	spinning.stop();
					
	}
		

	
		
	if (getprop("/options/mini-panel") == 1) {
		minipanel_dlg.open();
	}
	if (getprop("/options/dash") == 1) {
    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "dash" }));
	}
	if (getprop("/options/prs") == 1) {
    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "dpresets" }));
	}
		if (getprop("/options/trp") == 1) {
    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "trim-panel" }));
	}


});

	

	
var readSettings = func {
	io.read_properties(getprop("/sim/fg-home") ~ "/Export/FG-Platypus-config.xml", "/systems/acconfig/options");
	setprop("/options/autocoordinate", getprop("/systems/acconfig/options/autocoordinate"));
	setprop("/options/show-l-yoke", getprop("/systems/acconfig/options/show-l-yoke"));
	setprop("/options/show-r-yoke", getprop("/systems/acconfig/options/show-r-yoke"));
		setprop("/options/mini-panel", getprop("/systems/acconfig/options/mini-panel"));
	setprop("/options/panel", getprop("/systems/acconfig/options/panel"));
	autopilotSettings();
}

var writeSettings = func {
	setprop("/systems/acconfig/options/autocoordinate", getprop("/options/autocoordinate"));
	setprop("/systems/acconfig/options/show-l-yoke", getprop("/options/show-l-yoke"));
	setprop("/systems/acconfig/options/show-r-yoke", getprop("/options/show-r-yoke"));
	setprop("/systems/acconfig/options/limits", getprop("/options/limits"));
	setprop("/systems/acconfig/options/panel", getprop("/options/panel"));
	setprop("/systems/acconfig/options/mini-panel", getprop("/options/mini-panel"));
	autopilotSettings();
	io.write_properties(getprop("/sim/fg-home") ~ "/Export/FG-Platypus-config.xml", "/systems/acconfig/options");
}

var autopilotSettings = func {
	if (getprop("/options/panel") == "HSI Panel") {
		setprop("/it-autoflight/internal/hsi-equipped", 1);
	} else {
		setprop("/it-autoflight/internal/hsi-equipped", 0);
	}
}
	






var saveSettings = func {
	aircraft.data.add("/options/panel","/options/autocoordinate","/options/qnh","/options/limits","/options/mini-panel");
("/instrumentation/nav/radials/selected-deg");


	aircraft.data.save();
}

saveSettings();

if (getprop("/systems/autofuel") == 0)  {

	setprop("/sim/model/equipment/ground-services/fuel-truck/enable", 1);
	
	}


var systemsReset = func {
	systems.elec_init();
	systems.engine_init();
	systems.fuel_init();
    itaf.ap_init();
	libraries.variousReset();


}

################
# Panel States #
################

# Cold and Dark
var colddark = func {
	spinning.start();
	ps_load_dlg.open();
	setprop("/systems/acconfig/autoconfig-running", 1);
	# Initial shutdown, and reinitialization.
	setprop("/controls/flight/flaps", 0.0);
	setprop("/controls/flight/elevator-trim", 0);
	systemsReset();
	if (getprop("/engines/engine[0]/rpm") < 421) {
		colddark_b();
	} else {
		var colddark_eng_off = setlistener("/engines/engine[0]/rpm", func {
			if (getprop("/engines/engine[0]/rpm") < 421) {
				removelistener(colddark_eng_off);
				colddark_b();
			}
		});
	}
}
var colddark_b = func {
	# Continues the Cold and Dark script, after engines fully shutdown.
	setprop("/systems/acconfig/autoconfig-running", 0);
	ps_load_dlg.close();
	ps_loaded_dlg.open();
	spinning.stop();
}

# Ready to Start Eng
var beforestart = func {
	spinning.start();
	ps_load_dlg.open();
	setprop("/systems/acconfig/autoconfig-running", 1);
	# First, we set everything to cold and dark.
	setprop("/controls/flight/flaps", 0.0);
	setprop("/controls/flight/elevator-trim", 0);
	systemsReset();
	
	# Now the Startup!
	setprop("/controls/electrical/battery", 1);
	setprop("/controls/electrical/alternator", 1);
	setprop("/controls/switches/beacon", 1);
	setprop("/controls/switches/strobe-lights", 1);
	setprop("/controls/switches/avionics-master", 1);
	setprop("/systems/fuel/selected-tank", 1);
	setprop("/systems/acconfig/autoconfig-running", 0);
	ps_load_dlg.close();
	ps_loaded_dlg.open();
	spinning.stop();
}

# Ready to Taxi
var taxi = func {
	spinning.start();
	ps_load_dlg.open();
	setprop("/systems/acconfig/autoconfig-running", 1);
	# First, we set everything to cold and dark.
	setprop("/controls/flight/flaps", 0.0);
	setprop("/controls/flight/elevator-trim", 0);
	setprop("/controls/flight/rudder-trim", 0);

	systemsReset();
	
	# Now the Startup!
	setprop("/controls/electrical/battery", 1);
	setprop("/controls/electrical/alternator", 1);
	setprop("/systems/electrical/CPT-FLT-Inst", 27);
	setprop("/controls/switches/beacon", 1);
	setprop("/controls/switches/strobe-lights", 1);
	setprop("/controls/switches/nav-lights-factor", 1);
	setprop("/controls/switches/avionics-master", 1);
	setprop("/systems/fuel/selected-tank", 1);
	setprop("/controls/engines/engine[0]/mixture", 1);
	setprop("/controls/engines/engine[0]/throttle", 0.3);
	setprop("/controls/engines/engine[0]/magnetos-switch", 4);
	interpolate("/controls/engines/engine[0]/throttle", 0.18, 3);

	settimer(func {
		setprop("/controls/engines/engine[0]/magnetos-switch", 3);
		setprop("/systems/acconfig/autoconfig-running", 0);
		ps_load_dlg.close();
			if(getprop("/systems/nbat")== 0){
				ps_loaded_dlg.open();
				spinning.stop();
			} else {			
				ps_loaded_ns_dlg.open();
				spinning.stop();
			}

	}, 3);
}
	
# Ready to Takeoff
var takeoff = func {
	# The same as taxi, except we set some things afterwards.
	taxi();
	var eng_one_chk_c = setlistener("/engines/engine[0]/rpm", func {
		if (getprop("/engines/engine[0]/rpm") >= 421) {
			removelistener(eng_one_chk_c);
			setprop("/controls/switches/fuel-pump", 1);
			setprop("/engines/engine/fuel-pressure-psi", 5.9);
			setprop("/controls/switches/landing-light", 1);
			setprop("/sim/rendering/als-secondary-lights/use-landing-light", 1);
			setprop("/controls/flight/elevator-trim", -0.01);
	
		}
	});
}
