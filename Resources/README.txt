This folder contains some files to tweak the standard vanilla configuration of the Flightgear Installation.
Use at your own risk!

commandlines


The default launcher after a fresh installation has no commandlines under settings.

To save you repeated typing if you always want to start up with lets say the same screen resolution etc its a good idea to add whatever startup option you like only once.

Simply highlight all of the text of the commandline file, copy and paste it to the settings page of the launcher at the bottom.
Add your own preferences.
For more info consult the getstart manual (section 4.3.1) and or check out the How to Getting Started menu option and scroll to the bottom to the section How To s ... commandlines

---------------------------------------------------------------

alternative_keyboard.xml

  
Flightgear comes with a generic keyboard definition file found in the root folder  ..../Flightgear/data/keyboard.xml
In addition some aircrafts like the Navigator have their own keyboard definition file containing custom key settings.

If for example you may wish to have consistency when flying other aircrafts and you rather press the letter f instead of moving the throttle with the mouse or perhaps press a to display the airport search dialog instead of clicking two menu options you can replace the original ..../Flightgear/data/keyboard.xml with the above file.
To do so, first rename the original to something like orig_keyboard, then copy the above to the data folder and rename it to keyboard.xml.

If you have a slow sluggish under powered machine flying using the keyboard is at times difficult as the keyboard response lags a bit and there is a tendency to over control rudder or ailerons or the elevator.
As such the above file has custom settings for the left, right, up and down arrow keys amongst other things.
You can always go back to the original keyboard or adjust settings to your liking if deemed necessary depending on your hardware configuration.

----------------------------------------------------------------

alt_environment.xml


Flightgear ships with two weather engine, basic and detailed, the latter being more realistic using predefined metar strings.
Of course you can also switch to real weather if flying online.

In case you want to explore the various scenarious aka CATI,II, Storms, Fog etc there is a rich collection to choose from.
However, some of the metars have extreme winds, gusts or rain downpooring in buckets making flying a little tricky or down right impossible if a newbie.

If you want lets say IFR(CATI)but with no or only a little wind you can easily modify the underlying metar.
Checkout the getstart manual,the IFR tutorial section 10.2 to learn how to do this.

However if you wish to use your own configs like snow, arctic, tropical or whatever you can create your own list of metars for repetitive use.

Before doing so you may need to google for info on how to decipher metar code.

If you have a need to create your own weather settings open the above file and modify existing scenarios, delete or add whatever, but keep the format exactly as is.

Then go to ../Flightgear/environment/environment.xml and rename the original file, then copy your version into the folder and rename it to environment.xml

Having done that, fire up FG, go to environment, weather, detailed, open the droplist for weather conditions and your custom list should be sitting there.

Select an entry, click apply, then close and voila....
