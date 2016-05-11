params ["_veh", "_factions", "_message"];

if (!isServer) exitWith {};
_unit = driver _veh;
if (isNil "_unit") exitWith{};
_unitSide = side _unit;
{
	if (_unitSide == _x) exitWith {
		_unit action ["Eject", _veh];
		unassignVehicle _unit;
		[_message,"hint",_unit] call BIS_fnc_MP;
	};
} forEach _factions;