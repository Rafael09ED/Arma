r0ed_SurvivableCrashes_OnVehicleCrash = compileFinal preprocessFileLineNumbers "r0ed_SurvivableCrashes\functions\fn_onVehicleCrash.sqf";
r0ed_SurvivableCrashes_VehicleInit = compileFinal preprocessFileLineNumbers "r0ed_SurvivableCrashes\functions\fn_vehicleInit.sqf";
r0ed_SurvivableCrashes_PlaySfx = compileFinal preprocessFileLineNumbers "r0ed_SurvivableCrashes\functions\fn_playSfx.sqf";

[] execVM "r0ed_SurvivableCrashes\functions\init\init_default.sqf";

if(hasInterface) then {
	player addEventHandler ["GetInMan", {
		params ["_unit", "_position", "_veh"];
		if(hasInterface) then {
			if(_unit == player) then {
				[_veh] call r0ed_SurvivableCrashes_VehicleInit;
			};
		};
		[_veh] remoteExec ["r0ed_fnc_vehicleInit", 2];
	}];
}