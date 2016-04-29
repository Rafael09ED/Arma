# Arma 3 Survivable Crashes  

**Author:** Rafael09ED

**Version:** 1.2

Allows the crew of a vehicle to survive it's destruction and escape harmed. The script was designed for ACE 3, but is Vanilla compatible.

### Installation:

1. Copy the folder "f" and the folder "sounds" to the mission directory
2. Merge the description.ext file to the one in your mission directory
3. Put the following line of code into your init.sqf file: 
`
	[player] execVM "f\crash\fn_handleUnitDamage.sqf";
`
4. Put the following code in the init of each vehicle you want it applied to:
`
    0 = [this] execVM "f\crash\fn_survivableCrashVehicle.sqf";
`

5. If using ACE3, The Medical module's 'Prevent Instant Death' setting must be turned on. 


### Change Log: 

#### 1.2.2 - MP Hotfix
- Fixed bug prevent script from working in MP

#### 1.2
- Better crash impact
- Fixed Autorotation Warning SFX

#### 1.1 - dev
- No longer dependent on ACE 3
- New Visual Effects
- Some tweaking of variables
- Some refactoring
- No longer requires ACE's Disable Instant Death

#### 1.0
- Initial Release

### Videos:

ACE3 	: https://www.youtube.com/watch?v=PV9u3UXykHc
Vanilla	: https://www.youtube.com/watch?v=aT3E_Mk7cts
