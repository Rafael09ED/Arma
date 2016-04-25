_unit = _this select 0;
[_unit, true, 15 + random 10] call ace_medical_fnc_setUnconscious; 
[_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
_unit allowDamage false;
_eventIndex = _unit addEventHandler ["HandleDamage", {0}];
waitUntil {
	sleep .5 + random 2; _alt = (getPosATL _unit) select 2;
	_alt < 1.5;
};
sleep random 1;
_unit action ["eject", vehicle _unit];
// ragdoll
_ragdoll = _unit spawn {
	private "_rag";
	_unit = _this;
	_rag = "Steel_Plate_L_F" createVehicleLocal [0, 0, 0];
	_rag setObjectTexture [0, ""];
	_rag setMass 500;
	_dir = (direction _unit) + 45 - random 90;
	_rag setDir _dir;
	_bbr = boundingBoxReal _unit;
	_unitPos = getPos _unit;
	_rag setPosATL [
		(_unitPos select 0) + sin(_dir + 180), (_unitPos select 1) + cos(_dir + 180),
		(abs (((_bbr select 1) select 2) - ((_bbr select 0) select 2)))/2];
	_rag setVelocity [(sin(_dir)) * 12, (cos(_dir)) * 12, .7 - random 1]; 
	sleep 0.5;
	deleteVehicle _unit;
};
sleep 5 + random 7;
waitUntil {sleep random 1; scriptDone _ragdoll};
_unit removeEventHandler ["HandleDamage", _eventIndex];
_unit allowDamage true;
[_unit,_unit] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;
{
	_cause = ["vehiclecrash", "explosive"] select (round random 1);
	[_unit, random 1, _x, _cause] call ace_medical_fnc_addDamageToUnit;
	sleep .2;
} forEach ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
[_unit, false] call ace_medical_fnc_setUnconscious; 