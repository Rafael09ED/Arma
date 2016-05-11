/*
Add Script to vehicles spawned by COS.
_veh = Vehicle. Refer to vehicle as _veh.
*/

_veh =(_this select 0);
if(isServer) then {
	_veh addEventHandler ["getin", {
		_vehEntered = _this select 0;
		[_vehEntered, [resistance], "Your Driver's License is not valid here"] execvm 'f\civ\vehicleCheck.sqf';
	}];
	_veh addEventHandler ["SeatSwitched", {
		_vehEntered = _this select 0;
		[_vehEntered, [resistance], "Your Driver's License is not valid here"] execvm 'f\civ\vehicleCheck.sqf';
	}];
};
if (isServer) exitWith {};

_veh addEventHandler ["getin", {
	_vehEntered = _this select 0;
	_personEntered = _this select 2;
	if (side _personEntered == west) then {
		_handle = [{	 
			params ["_args", "_idPFH"];
			_args params ["_driver", "_vehicle", "_maxSpeed"];
			if (_driver == driver _vehicle) then {
				private _speed = speed _vehicle;
				if (_speed > _maxSpeed) then {
					_vehicle setVelocity ((velocity _vehicle) vectorMultiply ((_maxSpeed / _speed) - 0.00001));
				};
			};
		} , 0, [_personEntered, _vehEntered, 50]] call CBA_fnc_addPerFrameHandler;
		_personEntered setVariable ["VehicleSpeedLimiter",_handle];
	};
}];
_veh addEventHandler ["GetOut", {
	_personEntered = _this select 2;
	_handle = _personEntered getVariable ["VehicleSpeedLimiter",0];
	if (_handle != 0) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
		_personEntered setVariable ["VehicleSpeedLimiter",0];
	};
}];
_veh addAction [
	"Order Driver Out", 
	{
		[[[_veh, [civilian], "You have been ordered out"],"f\civ\vehicleCheck.sqf"], "BIS_fnc_execVM", _veh] call BIS_fnc_MP;
	},"" , 7, true, true, "", "(side _this) ==	east"];
[_veh] execVM "f\crash\fn_survivableCrashVehicle.sqf";
