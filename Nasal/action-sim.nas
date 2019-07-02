#   Initialize local variables
var rpm = nil;
var fuel_pres = 3.5;
var oil_pres = 0.0;
var factor = nil;
var ias = nil;
var flaps = nil;
var gforce = nil;
var stall = nil;
var bsw = nil;
var node = nil;
var OnGround = nil;
var fuel_flow = nil;
var egt = nil;
var fuel_pump_volume = nil;
var factorAGL = 0.0;
var initDone = 0;

# set up filters for these actions

var init_actions = func {
    setprop("engines/engine[0]/fuel-flow-gph", 0.0);
    setprop("/surface-positions/flap-pos-norm", 0.0);
    setprop("/instrumentation/airspeed-indicator/indicated-speed-kt", 0.0);
    setprop("/instrumentation/airspeed-indicator/pressure-alt-offset-deg", 0.0);
    setprop("/accelerations/pilot-g", 1.0);
    setprop("/controls/flight/aileron_in", 0.0);
    setprop("/controls/flight/elevator_in", 0.0);
    setprop("/sim/model/material/LandingLight/factor", 0.0);  
    setprop("/sim/model/material/LandingLight/factorAGL", 0.0);  

    if (initDone)
        return;
    initDone = 1;

    # Make sure that init_actions is called when the sim is reset
    setlistener("sim/signals/reset", init_actions); 

    # Request that the update fuction be called next frame
    settimer(update_actions, 0);
}

var update_actions = func {
##
#  This is a convenient cludge to model fuel pressure and oil pressure
##
    rpm = getprop("/engines/engine/rpm");
    if (rpm > 600.0) {
       fuel_pres = 6.8-3000/rpm;
       oil_pres = 62-12600/rpm;
    } else {
       fuel_pres = 0.0;
       oil_pres = 0.0;
    }

    if (getprop("/controls/engines/engine/fuel-pump")) {
    fuel_pres += 1.5;
    }

##
#  reduce fuel pump sound volume as rpm increases
##
   if (rpm < 1200) {
     fuel_pump_volume = 0.75/(0.002*rpm+1)
   } else {
     fuel_pump_volume = 0.0
   }

##
#  Stall Warning
##
    ias = getprop("/instrumentation/airspeed-indicator/indicated-speed-kt");
    flaps = getprop("/surface-positions/flap-pos-norm");
    gforce = getprop("/accelerations/pilot-g");
#    print("ias = ", ias, "  flaps = ", flaps);
#  pa28-161 Vs = 50 knots,  warn at 52
    stall = 50 - 7*flaps + 20*(gforce - 1.0);
    node = props.globals.getNode("/sim/alarms/stall-warning",1);
    if ( ias > stall ) {
      node.setBoolValue(0);
    }
    else {
      node.setBoolValue(1);
    }

##
#  Simulate egt from pilot's perspective using fuel flow and rpm
##
    fuel_flow = getprop("engines/engine[0]/fuel-flow-gph");
    egt = 325 - abs(fuel_flow - 10)*20;
    if (egt < 20) {egt = 20; }
    egt = egt*(rpm/2400)*(rpm/2400);

##
#  Simulate landing light ground illumination fall-off with increased agl distance
##
    var factorAGL = getprop("sim/model/material/LandingLight/factor");
    var agl = getprop("position/altitude-agl-ft");
    var aglFactor = 10000/(agl*agl);
   if (agl > 100) { 
       factorAGL = factorAGL*aglFactor;
    }

##
#  Disengage Joystick aileron if autopilot is controlling roll
##

  if ( getprop("autopilot/KAP140/locks/roll-axis")) { 
      aileron = getprop("controls/flight/AP_aileron");
  }
  else {
      aileron = getprop("controls/flight/aileron");
  }

##
#  Disengage Joystick elevator if autopilot is controlling pitch
##

  if ( getprop("autopilot/KAP140/locks/pitch-axis")) {
      elevator = getprop("controls/flight/AP_elevator");
  }
  else {
      elevator = getprop("controls/flight/elevator");
  }

    # outputs
    setprop("/controls/flight/aileron_in", aileron);
    setprop("/controls/flight/elevator_in", elevator);
    setprop("/sim/model/material/LandingLight/factorAGL", factorAGL);
    setprop("/sim/sound/fuel_pump_volume", fuel_pump_volume);

    settimer(update_actions, 0);
}

# Setup listener call to start update loop once the fdm is initialized
# 
setlistener("/sim/signals/fdm-initialized", init_actions);  

##
#  stop the flight timer as the ap one resets on bounce
##

setlistener("/autopilot/route-manager/destination/touchdown-time", func {
	if (getprop("/gear/gear/wow") == 1) {
		davtron803.davtron_flight_time.stop();
    		setprop("/it-autoflight/input/ap", 0);
			var ld = (getprop("/instrumentation/clock/indicated-string"));

		if (getprop("/systems/takeoff") !=  nil) {

			setprop("/systems/landed", ld);
		}

    var ldg = props.globals.getNode("/systems/data/landings");
	ldg.setValue(ldg.getValue() + 1);

var tc = getprop("/instrumentation/davtron803/flight-time-secs");
	var ac = getprop("/systems/data/acc-flight-secs");
	var up = tc + ac;

    setprop("/systems/data/acc-flight-secs", up);

}});


#part of takeoff quickstart takeoff below

setlistener("/controls/flight/elevator", func {
		if (getprop("/controls/flight/elevator") >  - 0.09) {
			var rosp = getprop("/velocities/airspeed-kt");
			setprop("/systems/rsp",rosp );
			setprop("/systems/nopo",2 );
		}	
});

setlistener("/controls/gear/brake-parking", func {
	if (getprop("/controls/gear/brake-parking")== 0 ) {
		var ele = getprop("/position/altitude-ft");
	setprop("/systems/gel",ele );
	setprop("/systems/nopo",3 );
}});

##
#  capture takeoff time as it is reset by rm on bounce
##

var ab = setlistener("/autopilot/route-manager/departure/takeoff-time", func {
	if (getprop("/gear/gear/wow") == 0) {		
	var dt = (getprop("instrumentation/clock/indicated-string"));
	if (getprop("/systems/takeoff") ==  nil) {
	var dt = 0;
			setprop("/systems/takeoff", dt);	
	var tof = props.globals.getNode("/systems/data/takeoffs");
	tof.setValue(tof.getValue() + 1);
	var rem = removelistener(ab);
}

}});

#capture values for takeoff practise quickstart

	setlistener("/autopilot/route-manager/airborne", func {
	if(getprop("/autopilot/route-manager/airborne") == 1 and getprop("/engines/engine/rpm") > 2000) {		
		davtron803.davtron_flight_time.start();
		if (getprop("/systems/lapa") ==  1) {	

		var los = getprop("/velocities/airspeed-kt");
		var tpi = getprop("/orientation/pitch-deg");
		var tfl = getprop("/controls/flight/flaps");
		var tro = getprop("/orientation/roll-deg");
		var alf = getprop("/orientation/alpha-deg");
		var hel = getprop("/controls/flight/elevator");
		var gew = getprop("/fdm/jsbsim/inertia/weight-lbs");
		var nmt = getprop("/instrumentation/gps/trip-odometer");		
				setprop("/systems/tor", nmt*6076);
				setprop("/systems/tos", los);
				setprop("/systems/grw", gew);
				setprop("/systems/ald", alf);
				setprop("/systems/api", tpi);
				setprop("/systems/aro", tro);
				setprop("/systems/elv", hel);
				setprop("/systems/flt", tfl);			
	logger.screen.red("Sim paused for review,
	press Reset or Continue or ESC to quit...",2);
    fgcommand("dialog-show", props.Node.new({ "dialog-name" : "lifo" }));
	fgcommand("dialog-close", props.Node.new({ "dialog-name" : "speedo" }));
	setprop("/sim/freeze/clock",1);		
   } 
}});

#capture values for aborting takeoff roll 

##get the timer ready
	
	setlistener("/controls/gear/brake-parking", func {		
	if (getprop("/systems/gost") ==  1) {	
	if(getprop("/controls/engines/engine/throttle") > 0.75 and getprop("/controls/gear/brake-parking") == 0) {		
	davtron803.davtron_elapsed_time.stop();
	davtron803.davtron_elapsed_time.reset();
	davtron803.davtron_elapsed_time.start();
	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "speedo" }));		
	}	

}});

###capture accelleration data

	setlistener("/controls/engines/engine/throttle", func {

	if(getprop("/controls/engines/engine/throttle") == 0 and getprop("/velocities/airspeed-kt") > 25) {		

		if (getprop("/systems/gost") ==  1) {			
	
		var los = getprop("/velocities/airspeed-kt");
		var grs = getprop("/velocities/groundspeed-kt");
		var ttr = getprop("/instrumentation/davtron803/elapsed-time");
		var tfl = getprop("/controls/flight/flaps");
		var gew = getprop("/fdm/jsbsim/inertia/weight-lbs");
		var nmt = getprop("/instrumentation/gps/trip-odometer");
		
				setprop("/systems/odo1f", nmt*6076); ##ok
				setprop("/systems/odo1n", nmt);
var o1f = getprop("/systems/odo1f");
setprop("/systems/odo1mt", o1f * 0.304878);

				setprop("/systems/spd1", los);
				setprop("/systems/grw", gew);		
				setprop("/systems/flp", tfl);
				setprop("/systems/tim1", ttr);	
				setprop("/systems/gsp", grs);

	##restart timer for second part

	davtron803.davtron_elapsed_time.stop();
	davtron803.davtron_elapsed_time.reset();
	davtron803.davtron_elapsed_time.start();
   } 		

}});

###capture decelleration data

	setlistener("/gear/gear/rollspeed-ms", func {
	if (getprop("/instrumentation/gps/odometer") >  0.1) {	

	if(getprop("/controls/engines/engine/throttle") == 0 and getprop("/gear/gear/rollspeed-ms") < 1) {		
		if (getprop("/systems/gost") ==  1) {

		var sts = getprop("/velocities/airspeed-ms");
	var tts = getprop("/instrumentation/davtron803/elapsed-time");
		var ntt = getprop("/instrumentation/gps/trip-odometer");

davtron803.davtron_elapsed_time.stop();
		
				setprop("/systems/odo2f", ntt*6076);
				setprop("/systems/odo2n", ntt);			
				setprop("/systems/tim2", tts);
		var o2f = getprop("/systems/odo2f");
setprop("/systems/odo2mt", o2f * 0.304878);

    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "abort" }));
	fgcommand("dialog-close", props.Node.new({ "dialog-name" : "speedo" }));		

###some conversion to metric		
		
		var rwl = getprop("/systems/rwlg");
		var rwu = getprop("/systems/odo2f");
		var rws = getprop("/systems/odo1f");
		setprop("/systems/odosf", rwu-rws);
		setprop("/systems/remft", rwl-rwu);
		var rwm = getprop("/systems/remft");
		setprop("/systems/remmtr", rwm * 0.304878);
		var omt = getprop("/systems/odosf");
		setprop("/systems/odosmt", omt * 0.304878);
	}
}

}});  

# fuel consumption code from syd adams twin otter

var fuel_used_value = 0;
var last_fuel_read = 0;
var init = func {
	fuel_at_start = getprop("/consumables/fuel/total-fuel-gal_us");	
	last_fuel_read = getprop("/consumables/fuel/total-fuel-gal_us");
	print("Fuel Meter active...");	
	
	main_loop();
}

# Setup listener call to start update loop once the fdm is initialized
setlistener("sim/signals/fdm-initialized", init);

#main loop
var main_loop = func {
	fuel_used();	
	
	settimer(main_loop, 0);
}

#fuel used, for the fuel used instrument
var fuel_used = func{
	if(last_fuel_read==nil){
		last_fuel_read = getprop("/consumables/fuel/total-fuel-gal_us");
	}
	var fuel_read = getprop("/consumables/fuel/total-fuel-gal_us");
	if(fuel_read!=nil and last_fuel_read!=nil){
		var fuel_used_delta = last_fuel_read - fuel_read;
		if(fuel_used_delta<0){
			fuel_used_delta = 0;
		}
		if(getprop("/instrumentation/fuel-used-indicator/serviceable")){
			fuel_used_value = fuel_used_value + fuel_used_delta;
		}
		last_fuel_read = fuel_read;
		
		if(fuel_used_value>999.99){
			fuel_used_value = 999.99;
		}
		setprop("/consumables/fuel/total-fuel-used-gal_us",fuel_used_value);
	}
}

#fuel used reset, for the fuel used instrument
var reset_fuel_used = func{
	fuel_used_value = 0;
}		

##sync dme switch with nav switch

setlistener("/options/nav-source", func {
	if (getprop("/options/nav-source")== 3 ) {
		setprop("/instrumentation/dme/switch-position",3) ;
	    } else {
		setprop("/instrumentation/dme/switch-position",1) ;
		
}});

##display instructions for scen11

var sc11 = setlistener("/instrumentation/davtron803/flight-time-secs", func {
	if (getprop("/systems/dev")== 1) {
		 	
		if (getprop("/instrumentation/davtron803/flight-time-secs")> 360){
			setprop("/sim/rendering/clouds3d-enable",1);
			setprop("/environment/weather-scenario","Thunderstorm");
			fgcommand("dialog-show", props.Node.new({ "dialog-name" : "instruct11" }));	
			setprop("/sim/freeze/clock",1);
			setprop("/systems/dev",0);
			var rem = removelistener(sc11);
		}		
	}
	
	if (getprop("/options/trm")== 20) {
		 	
		if (getprop("/instrumentation/davtron803/flight-time-secs")> 600){
			setprop("/environment/weather-scenario","Thunderstorm");
			fgcommand("dialog-show", props.Node.new({ "dialog-name" : "instructdiv" }));	
			setprop("/sim/freeze/clock",1);
			setprop("/systems/div",0);
			var rem = removelistener(sc11);
		}	
	}
});

setlistener("/engines/engine/fuel-flow-gph", func {

	if (getprop("/engines/engine/fuel-flow-gph")> 0.2 ) {

		var remaining = getprop("/consumables/fuel/total-fuel-gal_us") ;
	var cflow = getprop("/engines/engine/fuel-flow-gph");
	var cspeed = getprop("/velocities/airspeed-kt");
	var fuel_time = remaining/cflow;
	setprop("/systems/remains",remaining);
		setprop("/systems/ftime",fuel_time);

	var mpg = cspeed/getprop("engines/engine/fuel-flow-gph");
	var fuel_reach = remaining * mpg;
	setprop("/systems/freach",fuel_reach);	
}});

##move viewbar if view 7 is activated

setlistener("/sim/current-view/view-number", func {
if (getprop("systems/vbo")== 1) {
	if (getprop("sim/current-view/view-number") == 7) {
		
		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "viewBarWarrior_h" }));
		setprop("/sim/gui/dialogs/viewBarWarrior_h/dialog/x",924);
		setprop("/sim/gui/dialogs/viewBarWarrior_h/dialog/y",675);
		fgcommand("dialog-show", props.Node.new({ "dialog-name" : "viewBarWarrior_h" }));

	    } else {
			fgcommand("dialog-close", props.Node.new({ "dialog-name" : "viewBarWarrior_h" }));

		setprop("/sim/gui/dialogs/viewBarWarrior_h/dialog/x",1);
		setprop("/sim/gui/dialogs/viewBarWarrior_h/dialog/y",1);
	
	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "viewBarWarrior_h" }));		
}	
}});

		setprop("/systems/vbo",0);	
##
#  toggle left brake for failure
##

setlistener("/systems/lbr", func {
	  if (getprop("/systems/lbr")== 3 ) {
setprop("/input/keyboard/key[44]/binding/script","controls.applyBrakes(0,-1)");
logger.screen.red("One of the brakes appears to be defective");
  }
  else {
      setprop("/input/keyboard/key[44]/binding/script","controls.applyBrakes(1,-1)");

}});

# get nearest airport data
# code adapted from bluebird and ap dialog

setlistener("/instrumentation/gps/odometer", func { 

var ap_callsign_Node = props.globals.getNode("/tracking/icao", 1);
var ap_dist_Node = props.globals.getNode("/tracking/distance-nm", 1);
var ap_elev_Node = props.globals.getNode("/tracking/elevation-ft", 1);
var ap_course_Node = props.globals.getNode("/tracking/course", 1);
var ap_name_Node = props.globals.getNode("/tracking/airport", 1);
var ap_lat_Node = props.globals.getNode("/tracking/latitude", 1);
var ap_lon_Node = props.globals.getNode("/tracking/longitude", 1);
var ap_long_Node = props.globals.getNode("/tracking/lgst_rw", 1);

      var MAX_RUNWAYS = 28; # number of entries at KEDW

	var a = airportinfo();
		apt = getprop("/sim/airports/closest-airport-id");	
		apt = a;
          var airport_pos = geo.Coord.new();
          airport_pos.set_latlon(apt.lat, apt.lon);

          var pos = geo.aircraft_position();
          var dst = pos.distance_to(airport_pos) / 1852.0;
          var crs = pos.course_to(airport_pos);
		var dlg = props.globals.getNode("/sim/gui/dialogs/napt", 1);
		var avail_runways = dlg.getNode("available-runways", 1);
          var longest_runway = 0;
          var runways = apt.runways;
          var infoAboutRunways = [];   # list of strings for display
          avail_runways.removeChildren("value");
          var runway_keys = sort(keys(runways), string.icmp);
          var i = 0;
          foreach(var rwy; runway_keys) {
              var r = runways[rwy];
              longest_runway = math.max(longest_runway, r.length * 3.28);		
		
              avail_runways.getNode("value[" ~ i ~ "]", 1).setValue(rwy);
			if (r.length * 3.28 == longest_runway) {
              var lgst_rw = sprintf("%3s %10d ft' / %03d deg", rwy, r.length * 3.28,
                                    r.heading);
			}
              if (r.ils != nil) {
                  lgst_rw = sprintf("%s %12.3f Mhz", lgst_rw,
                                    r.ils.frequency / 100);
              }

              append(infoAboutRunways, lgst_rw);

              i += 1;
              if (i == MAX_RUNWAYS)
                  break;
          }
		ap_callsign_Node.setValue(apt.id);		
		ap_name_Node.setValue(apt.name);
		ap_lat_Node.setValue(apt.lat);
		ap_lon_Node.setValue(apt.lon);
		ap_elev_Node.setValue(3.28 * apt.elevation);
		ap_dist_Node.setValue(dst);
		ap_course_Node.setValue(crs);
		ap_long_Node.setValue(lgst_rw);
});

#toggle alt arm button

setlistener("/it-autoflight/output/alt-arm", func {
	if (getprop("/it-autoflight/output/alt-arm")== 1 ) {
		setprop("/systems/ro",1) ;
	    } else {
		setprop("/systems/ro",0) ;		
}});

##switch nav source in ap bar

setlistener("/options/nav-source", func {
	if (getprop("/options/nav-source")== 1 ) {
		setprop("/systems/n1",1) ;
	    } else {
		setprop("/systems/n1",0) ;
		}
	if (getprop("/options/nav-source")== 2 ) {
		setprop("/systems/n2",1) ;		
	    } else {
		setprop("/systems/n2",0) ;
		}
	if (getprop("/options/nav-source") == 3) {
		setprop("/systems/n3",1) ;
		} else {
		setprop("/systems/n3",0) ;
}});

##switch buttons in ap bar

setlistener("/it-autoflight/input/lat", func {
	if (getprop("/it-autoflight/input/lat")== 1 ) {
		setprop("/systems/rl",0) ;
		setprop("/systems/ar",1) ;
	    } else {
		setprop("/systems/rl",1) ;
		}
	if (getprop("/it-autoflight/input/lat")== 0 ) {
		setprop("/systems/he",0) ;	
		setprop("/systems/ar",1) ;	
	    } else {
		setprop("/systems/he",1) ;
		}
	if (getprop("/it-autoflight/input/lat") == 2 and getprop("/it-autoflight/input/vert") == 1) {
		setprop("/systems/na",0) ;
		setprop("/systems/ar",1) ;
		} else {
		setprop("/systems/na",1) ;		

}});

setlistener("/it-autoflight/input/vert", func {
	if (getprop("/it-autoflight/input/vert")== 2 ) {
		setprop("/systems/ar",0) ;
		setprop("/systems/na",1) ;
	    } else {
		setprop("/systems/ar",1) ;
		
}});

setlistener("/fdm/jsbsim/inertia/weight-lbs", func {

var grw = getprop("/fdm/jsbsim/inertia/weight-lbs") ;
var tow = getprop("/limits/mass-and-balance/maximum-takeoff-mass-lbs");
		if (grw != tow) {
			var bla = (tow-grw);
			setprop("/systems/wdif",bla);	

}});
		
####disable weight dialog once airborne

setlistener("/gear/gear/wow", func {
	if (getprop("/gear/gear/wow") == 0) {		
	setprop("/sim/menubar/default/menu[102]/item[7]/enabled", 0);
	} else {
	setprop("/sim/menubar/default/menu[102]/item[7]/enabled", 1);
}});

setlistener("/sim/current-view/view-number", func {
	if (getprop("/sim/current-view/view-number") == 0) {
		
	setprop("/sim/menubar/default/menu[100]/item[8]/enabled", 1);

	} else {

	setprop("/sim/menubar/default/menu[100]/item[8]/enabled", 0);

}});

###############
## dive for scenario 13

var sc13 = setlistener("/sim/freeze/clock", func {
	if (getprop("/sim/freeze/clock") == 0 and getprop("/options/trm") == 13) {
	
		setprop("/it-autoflight/input/vs",-800) ;		
		setprop("/options/trm", 0);
	var rem = removelistener(sc13);
}});

##########################################
# Ground Detection from DR400
##########################################
var terrain_survol = func {
  var lat = getprop("/position/latitude-deg");
  var lon = getprop("/position/longitude-deg");

  var info = geodinfo(lat, lon);
  if (info != nil) {
    if (info[1] != nil){
      if (info[1].solid !=nil)
        setprop("/environment/terrain-type",info[1].solid);
      if (info[1].load_resistance !=nil)
        setprop("/environment/terrain-load-resistance",info[1].load_resistance);
      if (info[1].friction_factor !=nil)
        setprop("/environment/terrain-friction-factor",info[1].friction_factor);
      if (info[1].bumpiness !=nil)
        setprop("/environment/terrain-bumpiness",info[1].bumpiness);
      if (info[1].rolling_friction !=nil)
        setprop("/environment/terrain-rolling-friction",info[1].rolling_friction);
      if (info[1].names !=nil)
        setprop("/environment/terrain-names",info[1].names[0]);
    }         
  }else{
    setprop("/environment/terrain",1);
    setprop("/environment/terrain-load-resistance",1e+30);
    setprop("/environment/terrain-friction-factor",1.05);
    setprop("/environment/terrain-bumpiness",0);
    setprop("/environment/terrain-rolling-friction",0.02);
  }

  if(!getprop("sim/freeze/replay-state") and !getprop("/environment/terrain-type") and getprop("/position/gear-agl-m") < 0.5){
   gui.popupTip("Got that sinking feeling !", 6);
    setprop("sim/freeze/clock", 1);
    setprop("sim/freeze/master", 1);
setprop("/systems/data/rip", getprop("/systems/data/rip") + 1);

    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "choose" }));

  }
#  settimer(terrain_survol, 0);
}

############################################
# ELT System from Cessna337 taken from the DR400
# Authors: Pavel Cueto, with A LOT of collaboration from Thorsten and AndersG
# Adaptation by Clément de l'Hamaide and Daniel Dubreuil for DR400 or regent more adapted by Gerhard Kick for the Warrior
############################################
var eltmsg = func {
  var lat = getprop("/position/latitude-string");
  var lon = getprop("/position/longitude-string");
  var aircraft = getprop("/sim/description");
  var callsign = getprop("/sim/multiplay/callsign");
  
    if(getprop("/sim/crashed")){
      if(getprop("/instrumentation/elt/armed")) {
        var help_string = "ELT AutoMessage: " ~ aircraft ~ " " ~ callsign ~ " at " ~lat~" LAT "~lon~" LON, *** CRASHED ***";
        setprop("/sim/multiplay/chat", help_string);
        setprop("/sim/freeze/clock", 1);
        setprop("/sim/freeze/master", 1);
setprop("/systems/data/rip", getprop("/systems/data/rip") + 1);        
    setprop("sim/messages/copilot", "Hmm, those insurance premiums!");
    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "choose" }));
      }
    }
  ;	

  settimer(eltmsg, 0);  
};

  setlistener("/instrumentation/elt/armed", func(n) {
    if(n.getBoolValue()){
       var lat = getprop("/position/latitude-string");
       var lon = getprop("/position/longitude-string");
       var aircraft = getprop("/sim/description");
       var callsign = getprop("/sim/multiplay/callsign");
       var help_string = "ELT AutoMessage: " ~ aircraft ~ " " ~ callsign ~ " at " ~lat~" LAT "~lon~" LON, MAYDAY, MAYDAY, MAYDAY";
       setprop("/sim/multiplay/chat", help_string);
      }
    }
  );
  
 setlistener("/instrumentation/elt/test", func(n) {
    if(n.getBoolValue()){
       var lat = getprop("/position/latitude-string");
       var lon = getprop("/position/longitude-string");
       var aircraft = getprop("/sim/description");
       var callsign = getprop("/sim/multiplay/callsign");
       var help_string = "Testing ELT: " ~ aircraft ~ " " ~ callsign ~ " at " ~lat~" LAT "~lon~" LON";
       screen.log.write(help_string);
      }
    }
  );

############################################
# Global loop function
# If you need to run nasal as loop, add it in this function
############################################
global_system = func{

  terrain_survol();
  crashes();
  settimer(global_system, 0);
}

##########################################
# SetListerner must be at the end of this file
##########################################
setlistener("/sim/signals/fdm-initialized", func{
  setprop("/environment/terrain-type",1);
  setprop("/environment/terrain-load-resistance",1e+30);
  setprop("/environment/terrain-friction-factor",1.05);
  setprop("/environment/terrain-bumpiness",0);
  setprop("/environment/terrain-rolling-friction",0.02);
});

var nasalInit = setlistener("/sim/signals/fdm-initialized", func{

  settimer(eltmsg, 0);
  print('Emergency Locator Transmitter (ELT) loaded');
  settimer(global_system, 2);
  removelistener(nasalInit);
});

###set crashflag, needs a lot more conditions

var crashes= func {
  
  #settimer(crashes, 0);

if (getprop("/gear/gear/wow") == 0 and getprop("/position/gear-agl-m") < 0.1){
	
		setprop("/sim/crashed",1) ;
		setprop("/controls/engines/engine/magnetos-switch", 0);
		setprop("sim/freeze/clock", 1);
    		setprop("sim/freeze/master", 1);
	    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "choose" }));
	}
}

###############
## Engine on fire auto scenario every 200th start

var fireInit = setlistener("/engines/engine/running", func {
	if (getprop("/engines/engine/running") == 1) {

		if (getprop("/systems/starts") == 200 and getprop("/systems/saloft") == 0 ) {
		setprop("systems/orf", 0);
		setprop("hazards/fire/engine", 1);		

var delay = 4;
    settimer(func { 

	setprop("/sim/gui/dialogs/check2/dialog/group[1]/textbox/name","efs") ;		setprop("/sim/gui/dialogs/check2/dialog/group[1]/textbox/property","/sim/efs") ;
	    	fgcommand("dialog-close", props.Node.new({ "dialog-name" : "check2" }));
    	fgcommand("dialog-show", props.Node.new({ "dialog-name" : "check2" }));
		    }, delay);

	}
  removelistener(fireInit);

}});

##############
#if the fire is killed adhering to checklist
############################################

setlistener("/engines/engine/running", func {
	if (getprop("/engines/engine/running") == 1) {
		if (getprop("/hazards/fire/engine") == 1) {

	var delay = 120;
    settimer(func { 	
		
		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "check2" }));
		
fgcommand("dialog-show", props.Node.new({ "dialog-name" : "choose" }));

		    }, delay);
	}
}

	if (getprop("/controls/engines/engine/throttle") == 1 and getprop("/controls/engines/engine/mixture") == 0 and getprop("/controls/switches/fuel-pump") == 0 and getprop("/systems/fuel/selected-tank-knb") == 0) {	
			
		setprop("hazards/fire/engine", 0);
		fgcommand("dialog-close", props.Node.new({ "dialog-name" : "check2" }));
		gui.popupTip("Gee, that was close, well done!!!", 6);
		fgcommand("dialog-show", props.Node.new({ "dialog-name" : "choose" }));			
}});

#preset ils freq on change in routemanager runway_keys

	setlistener("/autopilot/route-manager/destination/runway", func {
	if (getprop("/autopilot/route-manager/destination/runway") != nil ) {	
	
		var cur_runway = getprop("autopilot/route-manager/destination/runway");
		var runways = airportinfo(getprop("autopilot/route-manager/destination/airport")).runways;
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
}});

#Fetch atis if route-manager destination ap changes

setlistener("/autopilot/route-manager/destination/airport", func {
	if (getprop("/autopilot/route-manager/destination/airport") != nil ) {			
		if (getprop("/systems/eap")==1) {		
var airport = airportinfo(getprop("autopilot/route-manager/destination/airport"));
var atis = airport.comms('atis');
if (!size(atis))
    atis = airport.comms('awos');
if (size(atis)== 0){
		print ("no atis data found, comm1 set to 111.1");			
		setprop("/instrumentation/comm/frequencies/selected-mhz", 111.11);
		} else {	
	setprop("/systems/catis",atis[0]);
	setprop("/instrumentation/comm/frequencies/selected-mhz", (getprop("/systems/catis")));	
}
}	
}});

