// Randomized Spawn Location for Pilots
// By Rafael09ED
if (!isServer) exitWith {};

_getpos = compile loadFile "f\pilot\locationGenerator.sqf";
_goodPos = [] call _getpos;

// Move Pilots
if (!isNil "down_pilot_1") then {
	_spawnPos = [_goodPos select 0, _goodPos select 1, (random 50) + 100];
	[[[_spawnPos, down_pilot_1],"f\pilot\movePilot.sqf"],"BIS_fnc_execVM",down_pilot_1] call BIS_fnc_MP;
};
if (!isNil "down_pilot_2") then {
	_posAround = [_goodPos, (random 8) + 4, random 360] call BIS_fnc_relPos;
	_spawnPos = [_posAround select 0, _posAround select 1, (random 50) + 100];
	[[[_spawnPos, down_pilot_2],"f\pilot\movePilot.sqf"],"BIS_fnc_execVM",down_pilot_2] call BIS_fnc_MP;
};
if (!isNil "down_pilot_3") then {
	_posAround = [_goodPos, (random 5) + 15, random 360] call BIS_fnc_relPos;
	_spawnPos = [_posAround select 0, _posAround select 1, (random 50) + 100];
	[[[_spawnPos, down_pilot_3],"f\pilot\movePilot.sqf"],"BIS_fnc_execVM",down_pilot_3] call BIS_fnc_MP;
};



// set marker and wreck  position
_dist = 125 + random 75;
_dir = random 360;
_markerPos = [(_goodPos select 0) + (sin _dir) * _dist, (_goodPos select 1) + (cos _dir) * _dist, 0];
"down_aircraft_marker" setMarkerPos _markerPos;
down_aircraft_wreck setPos _markerPos;
_location = createLocation [ "NameCity" , _markerPos getPos [50, -180], _dist * 1.25, _dist * 1.25];
_location setText "Downed Helicopter";

// set crate location
_weaponsPos = _markerPos findEmptyPosition [5,35];
if ( (count _weaponsPos) >= 1) then {
	down_aircraft_weapons setPos _weaponsPos;
} else {
	down_aircraft_weapons setPos (_markerPos getPos [(5 + random 5), random 360]);
};

sleep 1.5;

"HelicopterExploBig" createVehicle position down_aircraft_wreck;
"Bo_Mk82" createVehicle position down_aircraft_wreck;
"SmokeShellGreen" createVehicle position down_aircraft_weapons;
//createVehicle ["test_EmptyObjectForFireBig", position down_aircraft_wreck, [], 0, "CAN_COLLIDE"];
createVehicle ["test_EmptyObjectForSmoke", position down_aircraft_wreck, [], 0, "CAN_COLLIDE"];
_light = "#lightpoint" createVehicleLocal position down_aircraft_wreck;
//_light setLightBrightness 1.5;
_light setLightBrightness .7;
_light setLightAmbient[.25, 0.12, 0.0];
_light setLightColor[1.0,.5, 0];
_light lightAttachObject [down_aircraft_wreck, [0,0,.2]];

// create AI Patrols
_patrolPos 	= _goodPos vectorAdd [0, 750, 0];
_areaMarker = createMarker ["aiPatrolArea",_patrolPos];
_areaMarker setMarkerShape "RECTANGLE";
_areaMarker setMarkerSize [1500, 1250];
_aiLeaders 	=  synchronizedObjects patrolAI;
{
	_y = _x;
	_randAiPos = _markerPos getPos [1000 + random 500,(_goodPos getDir getMarkerPos "respawn_west") + (random 220) - 100];
	_squadUnits = units group _y;
	{
		_x setPosATL (_randAiPos findEmptyPosition [0, 50]);
	} forEach _squadUnits;
	[_y,"aiPatrolArea"] execVM "f\ai\ups.sqf";
} forEach _aiLeaders;

{
	_x flyInHeight 500;
	_wp = (group _x) addWaypoint [_markerPos,100];
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE_L";
	_wp setWaypointLoiterRadius 500;
}forEach [O_UAV_1, B_UAV_1];


