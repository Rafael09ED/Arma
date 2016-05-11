switch (playerSide) do {
    case west: {
       b_support_requester synchronizeObjectsAdd [player];
    };
    case east: {
        o_support_requester synchronizeObjectsAdd [player];
    };
};
if (serverCommandAvailable "#kick" OR !isMultiplayer) then {
	[] execVM "f\briefing\f_briefing_admin.sqf";
};
_unit = _this select 0;
_jip = _this select 1;
if (_jip) then {
	[_unit] call f_fnc_setGear; 
};