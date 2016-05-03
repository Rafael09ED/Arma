private["_logic"];
_logic = param [0,objNull,[objNull]];

[	_logic getVariable "ModEnabled",
	_logic getVariable "VisualEffects",
	_logic getVariable "SoundEffects",
	_logic getVariable "ExaggeratedEffects",
	_logic getVariable "MedicalSystem",
	_logic getVariable "CrewDamageMultiplier",
	compile (_logic getVariable "CrewPostCrashCode"),
	compile (_logic getVariable "VehicleRestCode")
] call compile preprocessFileLineNumbers "\r0ed_SurvivableCrashes\functions\init\init_survivableCrashes.sqf";

missionNamespace setVariable["r0ed_SurvivableCrashes_Initialized", true];