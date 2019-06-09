var tako = screen.display.new(10,-30);

var enableOSD = func() {	
	tako.setcolor(0.0,0.0,0.0);
	tako.format = "%.3g";
 	tako.add("/orientation/heading-deg");
	tako.add("/velocities/airspeed-kt");
	tako.add("/orientation/pitch-deg");
	tako.add("/orientation/roll-deg");
     tako.add("/velocities/vertical-speed-fps");
     tako.add("/environment/wind-from-heading-deg");
     tako.add("/environment/wind-speed-kt");
     tako.add("/orientation/alpha-deg");
}
var close_enableOSD = func { tako.close(); }
