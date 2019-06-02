# Copyright (C) 2015  FlightGear Team, Jonathan Schellhase (DG-505)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
###############################################################
#
# Custom limit functions and callouts for the PA28-Warrior taken  # from DHC-6 Twin Otter
#
# Originally taken from Aircraft/Generic/limits.nas
# Modified by Jonathan Schellhase (DG-505), Dec 2015
#
###############################################################

# Flaps extension limits
var checkFlaps = func(n) {
  var flapsetting = n.getValue();
  if (flapsetting == 0)
    return;
  var enabled = getprop("limits/warnings-enabled");
  var airspeed = getprop("instrumentation/airspeed-indicator/indicated-speed-kt");
  var ltext = "";
  var limits = props.globals.getNode("limits");
  if ((limits != nil) and (limits.getChildren("max-flap-extension-speed") != nil)) {
    var children = limits.getChildren("max-flap-extension-speed");
    foreach(var c; children) {
      if ((c.getChild("flaps") != nil) and
          (c.getChild("speed") != nil)     ) {
        var flaps = c.getChild("flaps").getValue();
        var speed = c.getChild("speed").getValue();
        if ((flaps != nil)        and
            (speed != nil)        and
            (flapsetting > flaps) and
            (airspeed > speed)    and
            (enabled == 1)           ) {
          ltext = "Flaps extended above maximum flap extension speed -
now inoperable ! ";
		setprop("/sim/failure-manager/display-on-screen", 0);            
		setprop("/sim/failure-manager/controls/flight/flaps/serviceable", 0);            
        }

        }
      }
    }
    if (ltext != "") {
      screen.log.write(ltext);
    } 	
}

# Set the listeners
setlistener("controls/flight/flaps", checkFlaps);

var checkG = func{
  if (getprop("/sim/freeze/replay-state"))
    return;
  var enabled = getprop("limits/warnings-enabled");
  var g = getprop("/accelerations/pilot-gdamped") or 1;
  var max_positive = getprop("limits/max-positive-g");
  var max_negative = getprop("limits/max-negative-g");
  var msg = "";
  if ((max_positive != nil) and (g > max_positive) and (enabled == 1)) {
    msg = "Airframe structural positive-g load limit exceeded!";
  }
  if ((max_negative != nil) and (g < max_negative) and (enabled == 1)) {
    msg = "Airframe structural negative-g load limit exceeded!";
  }
  if (msg != "") {
    screen.log.write(msg);
    settimer(checkG, 10);
  }
  else {
    settimer(checkG, 1);
  }
}
checkG();

# Airspeed limits
var checkVNE = func {
  if (getprop("/sim/freeze/replay-state"))
    return;
  var enabled = getprop("limits/warnings-enabled");
  var msg = "";
  var airspeed = getprop("instrumentation/airspeed-indicator/indicated-speed-kt");
  var altitude = getprop("position/altitude-ft");
  var vne    = getprop("limits/vne-0");
  var vs     = getprop("limits/vne-1");
  var vso    = getprop("limits/vne-2");

  if ((airspeed != nil) and (altitude != nil) and (vne != nil) and (airspeed > vne) and (altitude < 6700) and (enabled == 1)) {
    msg = "Airspeed exceeds Maximum Operating Speed! Reduce the speed!";
  }

  if ((airspeed != nil) and (altitude != nil) and (vs != nil) and (airspeed > vs) and (altitude >= 6700) and (altitude < 10000) and (enabled == 1)) {
    msg = "Stall Speed, increase speed !!!";
  }

  if ((airspeed != nil) and (altitude != nil) and (vso != nil) and (airspeed > vso) and (altitude >= 10000) and (altitude < 12001) and (enabled == 1)) {
    msg = "Stall Speed, increase speed !!!";
  }


  if (msg != "") {
    screen.log.write(msg);
    settimer(checkVNE, 10);
  }
  else {
    settimer(checkVNE, 1);
  }
}
checkVNE();

# Altitude limit
var checkALT = func {
   if (getprop("/sim/freeze/replay-state"))
    return;
  var enabled = getprop("limits/warnings-enabled");
  var msg = "";
  var altitude = getprop("position/altitude-ft");
  var max_alt = getprop("limits/max-alt");

  if ((altitude != nil) and (altitude > max_alt) and (enabled == 1)) {
    msg = "Maximum Operation Altitude exceeded! Descend!";
  }

  if (msg != "") {
    screen.log.write(msg);
    settimer(checkALT, 10);
  }
  else {
    settimer(checkALT, 1);
  }
}
checkALT();


# Prop RPM
var checkLHrpm = func {
  if (getprop("/sim/freeze/replay-state"))
    return;
    var enabled = getprop("limits/warnings-enabled");
    var msg = "";
    var LHrpm = getprop("engines/engine[0]/rpm");
    var LHrpm_limit = getprop("limits/max-prop-rpm");
    if ((LHrpm != nil) and (LHrpm_limit != nil) and (LHrpm > LHrpm_limit) and (enabled == 1)) {
      msg = "Left propeller exceeds maximum RPM! Reduce propeller pitch!";
  }
  if (msg != "") {
    screen.log.write(msg);
    settimer(checkLHrpm, 10);
  }
  else {
    settimer(checkLHrpm, 1);
  }
}

