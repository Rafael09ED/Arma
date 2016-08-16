private ["_unit","_unitType","_loadout","_loadoutUnitType","_unitTypeLoadouts"];

_unit = _this select 0;
_unitType = typeOf _unit;

_unitTypeLoadouts = missionNameSpace getVariable ["unitTypeLoadouts", []];
{
	
	_loadoutUnitType = _x select 0;
	if (_loadoutUnitType isEqualTo _unitType) then {
		_loadout = _x select 1;
		if (_x isKindOf "Man") then {
			[_unit, _loadout,true,true] call ace_common_fnc_setAllGear;
		} else {
			[_unit, _loadout] call BIS_fnc_loadInventory;
		};
		
	};
	
} forEach _unitTypeLoadouts;