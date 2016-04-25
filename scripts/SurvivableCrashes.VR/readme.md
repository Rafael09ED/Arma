# Arma 3 Survivable Crashes  
@author: 	Rafael09ED
@version:	1.0

Installation:
1. Copy the folder "f" and the folder "sounds" to the mission directory
2. Merge the description.ext file to the one in your mission directory
3. Put the following code in the init of each vehicle you want it applied to:
	0 = [this] execVM "f\crash\fn_handleDamage_NoExplode.sqf";

Dependencies: 
	- ACE3
