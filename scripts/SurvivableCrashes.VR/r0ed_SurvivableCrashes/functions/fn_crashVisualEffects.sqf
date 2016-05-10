{
	_x spawn {
		params ["_name", "_priority", "_effect", "_handle"];
		while {
			_handle = ppEffectCreate [_name, _priority];
			_handle < 0
		} do {
			_priority = _priority + 1;
		};
		_handle ppEffectEnable true;
		_handle ppEffectAdjust _effect;
		_handle ppEffectCommit 0;
		waitUntil {
			sleep 2;
			vehicle player == player;
		};
		for "_i" from 5 to 0 step -1 do {
			_rnd = [];
			{
				if(typeName _x == "SCALAR") then {
					_rnd pushBack (_x * (_i/5 + random (_i/4)));
				} else {
					_rnd pushBack _x;
				};
			} forEach _effect;
			_handle ppEffectAdjust _rnd;
			_handle ppEffectCommit 1 + random 5;
			waitUntil {ppEffectCommitted _handle};
			sleep 1; 
		};
		_rnd = [];
		{
			if(typeName _x == "SCALAR") then {
				_rnd pushBack (0);
			} else {
				_rnd pushBack _x;
			};
		} forEach _effect;
		_handle ppEffectAdjust _rnd;
		_handle ppEffectCommit 5;
		_handle ppEffectEnable false;
		ppEffectDestroy _handle;
	};
} forEach [["ChromAberration", 200, [0.05, 0.05, true]],["DynamicBlur", 400, [10]]];
[] spawn {
	"crash" cutText ["","BLACK",0];
	sleep 2;
	while {
		vehicle player != player
	} do {
		"crash" cutText ["","BLACK IN", .7 + random .4];
		sleep 2 + random .5;
		"crash" cutText ["","BLACK OUT", 1.2 + random .5];
		sleep 4 + random 2;
	};
	for "_i" from 1 to 5 do {
		"crash" cutText ["","BLACK IN",1 + random 2];
		sleep 2 + random 1;
		"crash" cutText ["","BLACK OUT",1 + random 2];
		sleep 2 + random 1;
	};
	"crash" cutText ["","BLACK IN", .25];
};