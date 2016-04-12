private ["_unit","_unitType","_loadout","_loadoutUnitType","_unitTypeLoadouts"];

_unit = _this select 0;
_unitType = typeOf _unit;

_unitTypeLoadouts = missionNameSpace getVariable ["unitTypeLoadouts", []];
{
	
	_loadoutUnitType = _x select 0;
	if (_loadoutUnitType isEqualTo _unitType) then {
		_loadout = _x select 1;
		[_unit, _loadout,true,true] call ace_common_fnc_setAllGear;
	};
	
} forEach _unitTypeLoadouts;