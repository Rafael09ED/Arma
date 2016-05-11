/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/
_unit =(_this select 0);
// does not work due to ace

if(!local _unit) exitWith {};
_unit addEventHandler ["killed", {
	_killerSide = side ((_this select 0) getvariable ["ace_medical_lastDamageSource", [civilian]]);
	if (_killerSide == west or _killerSide == resistance) then {
		[["CivilianKilledByBlufor"],"BIS_fnc_showNotification"] call BIS_fnc_MP;
	};
}];
