_veh = _this select 0;

if (!isServer) exitWith {};
_unit = driver _veh;
if (isNil "_unit") exitWith{};
_unitSide = side _unit;
if (_unitSide == west or _unitSide == resistance ) then {
	_unit action ["Eject", _veh];
	["Your Driver's License is not valid here", "hint",_unit] call BIS_fnc_MP;
};