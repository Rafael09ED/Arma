params ["_unit"];
_medicalSystem = missionNamespace getVariable "r0ed_SurvivableCrashesVar_MedicalSystem";
_visualEffectsEnabled = missionNamespace getVariable "r0ed_SurvivableCrashesVar_VisualEffectsEnabled";
_damageMultiplier = missionNamespace getVariable "r0ed_SurvivableCrashesVar_CrewDamageMultiplier";
_crewPostCrashCode = missionNamespace getVariable "r0ed_SurvivableCrashesVar_CrewPostCrashCode";

switch (_medicalSystem) do {
    case "ACE": { 	
		[_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
		[_unit, true, 30 + random 10] call ace_medical_fnc_setUnconscious;
		_unit allowDamage false;		
	};
    case "VANILLA": { _unit allowDamage false;};
	case "LIMIT_DAMAGE": { _unit allowDamage false;};
    default {};
};
if (_visualEffectsEnabled && _unit == player) then {
	[] call r0ed_fnc_crashVisualEffects;
};

[_unit, _medicalSystem, _damageMultiplier, _crewPostCrashCode] spawn {
    params ["_unit", "_medicalSystem", "_damageMultiplier", "_crewPostCrashCode"];
	waitUntil {
		_alt = getPosATL _unit select 2;
		_speed = vectorMagnitude velocity _unit;
		_alt < 2 or _speed < .5
	};
	_unit action ["eject", vehicle _unit];
	if (vehicle _unit != _unit) then {
		moveOut _unit;
	};
	_unit switchMove "";
	_unitVelocity = velocity _unit;
	_unit setVelocity [0,0,0];

	private ["_ragdoll"];
	for "_i" from 0 to 5 do {
    	_ragdoll = [_unit, _unitVelocity] spawn {
	        params ["_unit", "_vel", "_rag"];
		    _rag = "Steel_Plate_L_F" createVehicleLocal [0, 0, 0];
		    _rag setObjectTexture [0, ""];
		    _rag setMass 500;
            _magn = 12;

		    _dir = (_vel select 0) atan2 (_vel select 1);
		    _dir2 = (direction _unit) - 10 + random 20;
		    if (_dir2 > 180) then {_dir = _dir - 360;};
		    _dir = (_dir + _dir2) / 2;

		    _rag setDir _dir;
		    _bbr = boundingBoxReal _unit;
		    _unitPos = getPos _unit;

		    _rag setPosATL [
		    	(_unitPos select 0) + sin(_dir + 180), (_unitPos select 1) + cos(_dir + 180),
		    	(abs (((_bbr select 1) select 2) - ((_bbr select 0) select 2)))/2];
		    _rag setVelocity [
		        (sin(_dir)) * _magn + (_vel select 0),
		        (cos(_dir)) * _magn + (_vel select 1),
		        (_vel select 2) + random 1];
		    sleep 0.5;
		    deleteVehicle _unit;
	    };
	    sleep .001;
	};
	waitUntil {sleep 1; scriptDone _ragdoll};
	sleep 1;
	waitUntil{sleep 1; isTouchingGround _unit};
	sleep 2;
	switch (_medicalSystem) do {
		case "ACE": { 	
			_unit allowDamage true;
			[_unit,_unit] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;
			{
				_cause = ["vehiclecrash", "explosive"] select (round random 1);
				[_unit, _damageMultiplier * random [.3, .7, 1], _x, _cause] call ace_medical_fnc_addDamageToUnit;
				sleep .1;
			} forEach ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
			[_unit, false] call ace_medical_fnc_setUnconscious;
			sleep .001;
			_unit allowDamage false;
			sleep 5;
			_unit allowDamage true;
		};
		case "VANILLA": {
			_unit setDamage (.8 * _damageMultiplier);
            sleep 5;
            _unit allowDamage true;
		};
		case "LIMIT_DAMAGE": { _unit allowDamage true;};
        default {};
    };
    [_unit] spawn _crewPostCrashCode;
};
