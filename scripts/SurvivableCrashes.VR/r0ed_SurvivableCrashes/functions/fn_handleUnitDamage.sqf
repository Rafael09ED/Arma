params ["_unit"];
private ["_medicalSys"];
_medicalSys = missionNamespace getVariable "r0ed_SurvivableCrashesVar_MedicalSystem";
if(_medicalSys == "NONE") exitWith {};
if (local _unit) then {
	_unit addEventHandler ["HandleDamage", {
		private ["_unit", "_part", "_dmg", "_handle", "_index", "_oldDamage"];
		
		_unit 		= _this select 0;
		_part 		= _this select 1;
		_dmg 		= _this select 2;
		_index 		= _this select 5;
		_oldDamage 	= _unit getHit _part;
		_returnDmg 	= _dmg;
		
		if(_index == -1) then { 
			_oldDamage = damage _unit;
		};
		if ((vehicle _unit) getVariable ["r0ed_SurvivableCrashes", false] && _dmg > .88) then {
			_medicalSys = missionNamespace getVariable "r0ed_SurvivableCrashesVar_MedicalSystem";
			switch (_medicalSys) do {
				case "ACE": {
					switch (_part) do {
						case "": {
							_unit setDamage .88;
							[_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
                            [_unit, true] call ace_medical_fnc_setUnconscious;
						};
						case "head": {
							_unit setHit [_part, .88];
                            [_unit, true] call ace_medical_fnc_setUnconscious;
						};
						default {
							_unit setHit [_part, .88];
						};
					};
					_returnDmg = 0;
				};
				case "VANILLA": {
					switch (_part) do {
						case "": {
							_returnDmg = .88;
							//_unit setDamage .88;
						};
						case "head";
						case "body": {
							_returnDmg = .88;
							//_unit setHit [_part, .88];
						};
						default {
							_returnDmg = .88;
							//_unit setHit [_part, 1 min _dmg];
						};
					};
				};
				default {};
			};
			//_dmg = 0;
		};
		//systemChat format ["%1 %2 | %3 -> %4", _part, _oldDamage, _dmg, _returnDmg];
		_returnDmg
		
	}];
};