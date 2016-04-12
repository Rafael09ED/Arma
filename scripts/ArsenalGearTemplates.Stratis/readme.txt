# Arma 3 Arsenal Gear Templates
@author: 	Rafael09ED
@version:	0.1

Installation:
1. Copy the folder "f" to the mission directory
2. Create a game logic module with the following text in the init:
	{   _x disableAI "ANIM";  } forEach synchronizedObjects this;  
	0 = [this] execVM "f\assignGear\f_setLoadoutRoleModel.sqf";
3. Merge the description.ext and initPlayerLocal.sqf files to the mission directory
3. Sync the game logic to each unit you want to use as a template loadout
4. Set the loadout of each unit synced using the arsenal

Units of the same type as the template units will be created with the corresponding loadout

Dependencies: 
	- ACE3

Notes:
	There is currently no exception system to prevent unit loadouts from being changed
	The script is untested for JIP
	
This script is provided as is, without warranty of any kind. The author is not responsible for any direct, indirect, incidental or consequential damage of any kind, without limitation.
