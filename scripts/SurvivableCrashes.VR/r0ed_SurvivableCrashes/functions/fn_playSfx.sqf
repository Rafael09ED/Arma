params ["_veh"];
private ["_soundLoop"];

if (!hasInterface) exitWith{};
if (vehicle player != _veh && player distance _veh >  1000) exitWith{};

_soundLoop = _veh spawn { 
	for "_i" from 1 to 60 do { 
	_dist = _this distance player;
		if (_dist < 1) then {
			_this say3D ["AutorotationWarn", 4, 1]; 
		} else {
			_this say3D ["AutorotationWarn", (4 / _dist) ^ 2, 1];
		};
		sleep 1.105;
	};
};
waitUntil {
	sleep 1; 
	isTouchingGround _veh or !alive _veh
};
terminate _soundLoop;