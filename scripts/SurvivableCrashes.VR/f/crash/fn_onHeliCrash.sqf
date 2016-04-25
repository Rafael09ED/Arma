_targ = _this select 0;
_targ setFuel 0;
_targ setHitPointDamage ["HitHRotor",.88];
_targ setHitPointDamage ["HitVRotor",.88];
_targ setHitPointDamage ["HitEngine",.88];
_fire = createvehicle ["test_EmptyObjectForFireBig", position _targ,[],0,"CAN_COLLIDE"];
_fire attachTo [_targ,[0,0.0,0.0],"motor"];
_targ allowDamage false;
_targ spawn {
	_targ = _this;
	[[[_targ],"f\crash\fn_playSfx.sqf"],"BIS_fnc_execVM", true, true] call BIS_fnc_MP;
	waitUntil {
		sleep 1; _totalSpeed = 0;
		_alt = (getPosATL _targ) select 2;
		{_totalSpeed = _totalSpeed + _x} forEach velocity _targ;
		_totalSpeed < 20 && _alt < 5;
	};
	sleep 60 + random 30;
	_targ removeAllEventHandlers "HandleDamage";
	_targ allowDamage true;
	_targ setDamage 1;
};
{
	[[[_x],"f\crash\fn_localCrashEffects.sqf"],"BIS_fnc_execVM",_x, true] call BIS_fnc_MP
} forEach crew _targ;