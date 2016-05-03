params ["_unit"];
if (local _unit) then {
	_unit addEventHandler ["HandleDamage", {
		private ["_unit", "_part", "_dmg", "_handle", "_index", "_health"];
		_unit 	= _this select 0;
		_part 	= _this select 1;
		_dmg 	= _this select 2;
		_index 	= _this select 5;
		_health = _unit getHit _part;
		
		if(_index == -1) then { 
			_health = damage _unit;
		} else { 
			_health = _unit getHit _part; 
		};
		
		if ((vehicle _unit) getVariable ["r0ed_SurvivableCrashes", false] && _health + _dmg > .88) then {
			switch (_part) do {
				case "": {
					_unit setDamage .88;
				};
				case "head";
				case "body": {
					_unit setHit [_part, .88];
				};
				default {};
			};
			_dmg = 0;
		};
		_dmg
	}];
};