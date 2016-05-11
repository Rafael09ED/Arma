_pos = _this select 0;
_unit = _this select 1;
_chute = "Steerable_Parachute_F" createVehicle [0,0,0]; 
_chute setDir random 360;
_chute setPos _pos; 
_unit moveIndriver _chute;