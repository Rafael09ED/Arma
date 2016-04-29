_veh = _this select 0;
_veh setFuel 0;
_veh setDamage .88;
_veh setHitPointDamage ["HitHRotor",.88];
_veh setHitPointDamage ["HitVRotor",.88];
_veh setHitPointDamage ["HitEngine",.88];
_fire = createvehicle ["test_EmptyObjectForFireBig", position _veh,[],0,"CAN_COLLIDE"];
_fire attachTo [_veh,[0,0.0,0.0],"motor"];
_veh allowDamage false;
_veh spawn {
	_veh = _this;
	_alt = (getPosATL _veh) select 2;
	_aproxVel = velocity _this select 0 + velocity _this select 1 + velocity _this select 2;
	[[[_veh],"f\crash\fn_playSfx.sqf"],"BIS_fnc_execVM", true, true] call BIS_fnc_MP;
	waitUntil{isTouchingGround _veh};
	[_veh, _alt, _aproxVel] spawn {
		_veh = _this select 0;
		_alt = _this select 1;
		_aproxVel = _this select 2;
		
		_vel = velocity _veh;
		_dir = (_vel select 0) atan2 (_vel select 1); 
		_speed = 4 + random 2;
		_vel = [(sin _dir) * _speed * sqrt abs(_vel select 0), 
			(cos _dir) * _speed * sqrt abs(_vel select 1), 
			(10 + random 6) * sqrt ((_alt + 10) min 0) + sqrt(abs(_aproxVel)) + .4 ]; // being tested - post 1.2.1
		_veh setVelocity _vel;
		"HelicopterExploSmall" createVehicle position _veh;
	};
	waitUntil {
		sleep 1; _totalSpeed = 0;
		_alt = (getPosATL _veh) select 2;
		{_totalSpeed = _totalSpeed + _x} forEach velocity _veh;
		_totalSpeed < 20 && _alt < 5;
	};
	sleep 60 + random 30;
	_veh allowDamage true;
	_veh setDamage 1;
};
{
	[[[_x],"f\crash\fn_localCrashEffects.sqf"],"BIS_fnc_execVM",_x, true] call BIS_fnc_MP
} forEach crew _veh;
