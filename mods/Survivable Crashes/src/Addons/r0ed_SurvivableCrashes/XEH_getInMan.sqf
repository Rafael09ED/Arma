params ["_unit", "_unused1", "_veh"];

if(hasInterface) then {
	if(_unit == player) then {
		[_veh] call r0ed_SurvivableCrashes_VehicleInit;
	};
} else {
	[_veh] call r0ed_SurvivableCrashes_VehicleInit;
};