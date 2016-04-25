if (!hasInterface) exitWith{};
_targ = _this select 0;
_soundLoop = _targ spawn { 
	for "_i" from 1 to 60 do { 
		_this say3D ["AutorotationWarn", 3, 1]; 
		sleep 1.105;
	};
};
waitUntil {
	sleep 1; _totalSpeed = 0;
	_alt = (getPosATL _targ) select 2;
	{_totalSpeed = _totalSpeed + _x} forEach velocity _targ;
	(_totalSpeed < 15 && _alt < 2) or !alive _targ;
};
terminate _soundLoop;