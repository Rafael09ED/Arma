params ["_isEnabled",
    "_areVfxEnabled",
    "_areSfxEnabled",
    "_areExagFxEnabled",
    "_medicalSystemUsed",
    "_crewDamageMultiplier",
    "_vehicleKindWhitelist",
    "_onCrashCode",
    "_crewPostCrashCode",
    "_vehicleRestCode"
];

missionNamespace setVariable ["r0ed_SurvivableCrashesVar_ModEnabled", _isEnabled];
if(not _isEnabled) exitWith {};

missionNamespace setVariable ["r0ed_SurvivableCrashesVar_VisualEffectsEnabled", _areVfxEnabled];
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_SoundEffectsEnabled", _areSfxEnabled];
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_ExaggeratedEffectsEnabled", _areExagFxEnabled];
if (_medicalSystemUsed == "AUTO") then {
	if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
		_medicalSystemUsed = "ACE";
	} else {
		_medicalSystemUsed = "VANILLA";
	};
};
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_MedicalSystem", _medicalSystemUsed];
if(typeName _crewDamageMultiplier != "SCALAR") then {
    _crewDamageMultiplier = parseNumber _crewDamageMultiplier;
};
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_CrewDamageMultiplier", _crewDamageMultiplier];
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_VehicleKindWhitelist", _vehicleKindWhitelist];
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_OnCrashCode", _onCrashCode];
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_CrewPostCrashCode", _crewPostCrashCode];
missionNamespace setVariable ["r0ed_SurvivableCrashesVar_VehicleRestCode", _vehicleRestCode];

if(hasInterface) then {
	[player] execVM "r0ed_SurvivableCrashes\functions\fn_handleUnitDamage.sqf";
};
{
    _unit = _x;
    _veh = vehicle _x;
	if(_veh != _unit && not (_veh isKindOf "Man")) then {
		if(isServer or (hasInterface && _veh == vehicle player)) then {
			[_veh] call r0ed_SurvivableCrashes_VehicleInit;
		};
	};
} forEach allUnits;