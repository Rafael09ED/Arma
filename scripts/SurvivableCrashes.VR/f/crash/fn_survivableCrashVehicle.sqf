/*
	Survivable Crashes Script
	By: Rafael09ED
*/

_unit = _this select 0;
_unit setVariable ["SurvivableCrashes", true];

if (local _unit) then {
	_unit setVariable ["NotShotDown", true];
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
		if(_health == 1) exitWith {};
		
		if (_health + _dmg > 0.88) then {
			if (_index == -1 or _part == "hull_hit") then {
				_returnVal = 0;
				_isCrash = true;
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
