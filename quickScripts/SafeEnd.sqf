params["_location", ["_spacing", 2],["_invincibleTime", 5]];
private["_playersList", "_squareSize","_xCount","_yCount"];
_playersList = allPlayers - entities "HeadlessClient_F";
_squareSize = sqrt (count _playersList);
_xCount = (_location select 0) - (_squareSize * _spacing) / 2;
_yCount = (_location select 1) - (_squareSize * _spacing) / 2;
{
    _unit = _x;
    vehicle _unit setDamage 0;
    _unit allowDamage false;
    _unit setPos [_xCount,_yCount,0];
    _xCount = _xCount + _spacing;
    if(_xCount > (_location select 0) + (_squareSize * _spacing) / 2 ) then {
        _xCount = (_location select 0)- (_squareSize * _spacing) / 2;
        _yCount = _yCount + _spacing;
    };
} forEach _playersList;
if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
    {
        _unit = _x;
  [_unit,_unit] remoteExec ["ACE_medical_fnc_treatmentAdvanced_fullHealLocal", _unit];
  [_unit, false] remoteExec ["ace_medical_fnc_setUnconscious", _unit];
    } forEach _playersList;
};
[_playersList, _invincibleTime] spawn {
    params ["_playersList", "_invincibleTime"];
    sleep (_invincibleTime * 60);
    {
        _x allowDamage true;
    } forEach _playersList;
};
