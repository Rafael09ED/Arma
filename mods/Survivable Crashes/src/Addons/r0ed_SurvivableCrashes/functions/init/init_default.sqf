if(missionNamespace getVariable ["r0ed_SurvivableCrashes_Initialized", false]) exitWith {};

[	false,
	true,
	true,
	true,
	"AUTO",
	1,
	["Air"],
	{},
	{
		params["_veh"];
		sleep (40 + random 40);
		_veh allowDamage true;
		_veh setDamage 1;
	}
] call compile preprocessFileLineNumbers "\r0ed_SurvivableCrashes\functions\init\init_survivableCrashes.sqf"