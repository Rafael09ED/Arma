/*
	Survivable Crashes Script
	By: Rafael09ED
	Usage: 0=[this] execVM "f\crash\fn_survivableCrashVehicle.sqf";
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
_unit setVariable ["SurvivableCrashes", true];

if (local _unit) then {
	_unit setVariable ["NotShotDown", true];
	_unit setVariable ["Crash_CappedDamage", 0];
	_unit addEventHandler ["HandleDamage", {
		private ["_targ", "_part", "_dmg", "_index", "_health","_returnVal", "_isCrash"];
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
			if (_index == -1 or _part == "hull_hit") then {
				_returnVal = 0;
				_isCrash = true;
			} else {
				if (_part == "engine_hit" or _part == "main_rotor_hit" or _part == "fuel_hit") then {
					_val = (_targ getVariable "Crash_CappedDamage");
					if (_health >= .88 && damage _targ > .3) then {
						 _val = _val + _dmg;
					} else {
						_val = 0
					};
					_targ setVariable ["Crash_CappedDamage", _val];
					if (_val >= 4) then {
						_isCrash = true;
					};
				};
			};
			if(_isCrash) then {
				if (_targ getVariable "NotShotDown") then {
					_targ setVariable ["NotShotDown", false];
					[_targ] execVM "f\crash\fn_onCrash.sqf";
				};
			};
		};
		_returnVal
	}];
};
