sleep 6;
_side = side player;
if (time > 60) exitWith {};
if (_side == east or _side == west) then {
	"IntroFade" cutText ["", "BLACK",5];
	sleep 5;
	"IntroFade" cutText ["", "PLAIN",0];
	_colorWest = [west] call BIS_fnc_sideColor;
	_markerArray = [["\A3\ui_f\data\map\markers\nato\c_air.paa", _colorWest, getPos down_aircraft_wreck,  1, 1, 0, "", 0]];
	//true setCamUseTi 0;
	[
		getPos down_aircraft_wreck,
		"Behind Enemy Lines - Recover the Pilots",
		400,
		400,
		40,
		(random 1),
		_markerArray,
		0
	] call BIS_fnc_establishingShot;
    //waitUntil {!isNil "BIS_fnc_establishingShot_playing" && {!BIS_fnc_establishingShot_playing}};
    //false setCamUseTi 0;

};