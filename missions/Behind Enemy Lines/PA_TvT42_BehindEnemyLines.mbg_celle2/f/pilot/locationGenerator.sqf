private ["_isPosValid", "_goodPos", "_randPos"];
_isPosValid = false;
_goodPos = [0,0,0];

while {!_isPosValid} do {
	_randPos = [(random 11000) + 1000, (random 11000) + 1000, 0];
	if (_randPos distance2D getMarkerPos "respawn_west" > 4000) then {
		if (_randPos distance2D getMarkerPos "respawn_east" > 3000) then { 
			if ( (_randPos distance2D getMarkerPos "respawn_east") + 1000 < (_randPos distance2D getMarkerPos "respawn_west") ) then {
				if ( (_randPos distance2D getMarkerPos "respawn_east") * 2 > _randPos distance2D getMarkerPos "respawn_west") then {
					_goodPos = _randPos findEmptyPosition [0, 50];
					if ( (count _goodPos) >= 1) then {
						_isPosValid = true;
					};
				};
			};
		};
	};
};

_goodPos