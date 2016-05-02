/*
    SafeEnd by Rafael09ED
    Desc:
        Moves everyone to a passed location spaced out in a square
        Makes players invincible and restores them to full health
    Usage:
        [position, Allow Vehicles - default true, Spacing in meters - default 0 (auto), time invincible in minutes ] execVM "SafeEnd.sqf";
*/

params["_location", ["_allowVehicles", true], ["_spacing", 0],["_invincibleTime", 5]];
private["_playersList", "_vehiclesList", "_squareSize","_xCount","_yCount"];
_vehiclesList = [];
_playersList = allPlayers - entities "HeadlessClient_F";
{
    _unit = _x;
    _unit setDamage 0;
    _unit allowDamage false;
    if(_allowVehicles) then {
        _vehiclesList pushBackUnique vehicle _unit;
    } else {
        _vehiclesList pushBack _unit;
    };
} forEach _playersList;

if(_spacing == 0) then {
    {
        _unit = _x;
        _bbr = boundingBoxReal _unit;
        _p1 = _bbr select 0;
        _p2 = _bbr select 1;
        _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
        _maxLength = abs ((_p2 select 1) - (_p1 select 1));
        _spacing =_spacing max _maxWidth;
        _spacing =_spacing max _maxLength;
    } forEach _vehiclesList;
};
_spacing = _spacing min 50;

_squareSize = sqrt (count _vehiclesList);
_xCount = (_location select 0) - (_squareSize * _spacing) / 2;
_yCount = (_location select 1) - (_squareSize * _spacing) / 2;
{
    _unit = _x;
    _unit setDamage 0;
    _unit allowDamage false;
    _clearPos = [_xCount,_yCount] findEmptyPosition [0, _spacing/1.5, typeOf _unit];
    if (count _clearPos > 1) then {
            _unit setPos _clearPos;
    } else {
        {
            _x setPos [_xCount - (_spacing/2)+ random _spacing,
                _yCount - (_spacing/2)+ random _spacing,
                0];
        } forEach crew _unit;
    };
    _xCount = _xCount + _spacing;
    if(_xCount > (_location select 0) + (_squareSize * _spacing) / 2 ) then {
        _xCount = (_location select 0)- (_squareSize * _spacing) / 2;
        _yCount = _yCount + _spacing;
    };
} forEach _vehiclesList;

if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
    {
        _unit = _x;
        [_unit,_unit] remoteExec ["ACE_medical_fnc_treatmentAdvanced_fullHealLocal", _unit];
        [_unit, false] remoteExec ["ace_medical_fnc_setUnconscious", _unit];
    } forEach _playersList;
};

{
    [_x, [_vehiclesList, false]] remoteExec ["addCuratorEditableObjects", 2];
} forEach allCurators;

[_playersList + _vehiclesList, _invincibleTime] spawn {
    params ["_list", "_invincibleTime"];
    sleep (_invincibleTime * 60);
    {
        _x allowDamage true;
    } forEach _list;
};
