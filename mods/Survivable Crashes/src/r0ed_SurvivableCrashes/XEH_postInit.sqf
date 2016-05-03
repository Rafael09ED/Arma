[] execVM "\r0ed_SurvivableCrashes\functions\init\init_default.sqf";

if(hasInterface) then {
	[player] execVM "\r0ed_SurvivableCrashes\functions\fn_handleUnitDamage.sqf";
};