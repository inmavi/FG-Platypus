# PA28-161 prog wind config
# Copyright (c) 2018 Gerhard Kick

#############
# Init Vars #
#############

if (getprop("/options/trm")==10) {
	setlistener("/instrumentation/dme/indicated-distance-nm", func {	
	var cag = getprop("/instrumentation/dme/indicated-distance-nm");
	});
}
var wdawc_init = func {
	wdawc_timer.start();
}

##################
# Main Loop #
##################

var master_wdawc = func {	
	cag = getprop("/instrumentation/dme/indicated-distance-nm");
	if (getprop("/systems/awc")== 1) {		 	
		if (cag > 40 and cag < 40.1)  {

		fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windsim" }));			
 		setprop("/environment/config/boundary/entry/wind-from-heading-deg",182);
		setprop("/environment/config/boundary/entry/wind-speed-kt",20);

		gui.popupTip("Wind from 6 o clock @ 20 knots,
keep an eye on he groundspeed", 3);

		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));
		}
		if (cag > 33 and cag < 33.1)  {

		fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windsim" }));
			
 		setprop("/environment/config/boundary/entry/wind-from-heading-deg",92);
		setprop("/environment/config/boundary/entry/wind-speed-kt",30);

		gui.popupTip("Wind from 3 o clock @ 30 knots,
adjust heading for drift", 3);

		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));
		}

		if (cag > 24 and cag < 24.1)  {
			fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windsim" }));			
			setprop("/environment/config/boundary/entry/wind-from-heading-deg",272);
			setprop("/environment/config/boundary/entry/wind-speed-kt",37);
	gui.popupTip("Wind from 9 o clock @ 37 knots,
adjust your WCA", 3);
		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));
		}

		if (cag > 19 and cag < 19.1)  {			
 		
	gui.popupTip("Switch Nav1 frequency to Localiser -
and prepare for approach", 3);
		}

		if (cag > 16 and cag < 16.1)  {			
 		
	gui.popupTip("We are on the correct bearing, are we?
approaching slightly below the Glideslope", 3);
		}

		if (cag > 12 and cag < 12.1)  {

		fgcommand("dialog-show", props.Node.new({ "dialog-name" : "windsim" }));
			
 		setprop("/environment/config/boundary/entry/wind-from-heading-deg",02);
	setprop("/environment/config/boundary/entry/wind-speed-kt",16);

		gui.popupTip("Wind from 12 o clock @ 16 knots,
watch your engine settings on approach", 3);

		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "windsim" }));

		}
	}

};

###################
# Update Function #
###################

var update_wdawc = func {
	master_wdawc();
}
var wdawc_timer = maketimer(0.1, update_wdawc);


