private ["_roleModelUnits","_unitType","_loadout","_typeLoadout","_unitTypeLoadouts"];
if (!isServer) exitWith {};

_roleModelUnits = synchronizedObjects (_this select 0);
_unitTypeLoadouts = [];
{
	if (_x isKindOf "Man") then {
		_unitType = typeOf _x;
		_loadout = [_x] call ace_common_fnc_getAllGear;
		_typeLoadout = [[_unitType, _loadout]];
		_unitTypeLoadouts append _typeLoadout;
		if(isMultiplayer) then {
			deleteVehicle _x;
		}
	};
} forEach _roleModelUnits;

missionNameSpace setVariable ["unitTypeLoadouts", _unitTypeLoadouts];
publicVariable "unitTypeLoadouts";

{
	_array = [_x];
	[_array,"f_fnc_setGear", _x,true] call BIS_fnc_MP;
} forEach allUnits;