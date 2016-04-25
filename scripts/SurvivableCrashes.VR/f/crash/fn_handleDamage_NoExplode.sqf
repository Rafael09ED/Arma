/*
	No Deadly Helicopter Crashes Script
	By: Rafael09ED
	Usage: 0=[this] execVM "f\crash\fn_handleDamage_NoExplode.sqf";
	description.ext:
		class CfgSounds {
			class AutorotationWarn
			{
				name = "AutorotationWarn";
				sound[]={"sound\ACE_AutorotationWarning.ogg",4,1};
				titles[]={};
			};
		};
*/

_unit = _this select 0;

if (!local _unit) exitWith {};
_unit setVariable ["NotShotDown", true];
_unit addEventHandler ["HandleDamage", {
	private ["_targ","_dmg"];
	_targ 	= _this select 0;
	_part 	= _this select 1;
	_dmg 	= _this select 2;
	_index 	= _this select 5;
	_isCrash = false;
	_returnVal = _dmg;
	_health = 0;
	
	if(_index == -1) then {
		_health = damage _targ;
	} else {
		_health = _targ getHit _part;
	};
	if (_health + _dmg > 0.88) then {
		if (_index == -1) then {
			_returnVal = 0;
			_targ setDamage .88;
			_isCrash = true;
		};
		if(_isCrash) then {
			if (_targ getVariable "NotShotDown") then {
				_targ setVariable ["NotShotDown", false];
				[_targ] execVM "f\crash\fn_onHeliCrash.sqf";
			};
		};
	};
	_returnVal
}];