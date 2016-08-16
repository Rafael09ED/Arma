// Interface from F3 - Folk ARPS Assign Gear Script to Template Gear Script
private ["_typeofUnit","_unit"];

_unit = _this select 1;
if(_unit isKindOf "Man"){
	_unit remoteExec ["removeBackpack", _unit];
	_unit remoteExec ["removeAllWeapons", _unit];
	_unit remoteExec ["removeAllItemsWithMagazines", _unit];
	_unit remoteExec ["removeAllAssignedItems", _unit];
} else {
	clearWeaponCargoGlobal _unit;
	clearMagazineCargoGlobal _unit;
	clearItemCargoGlobal _unit;
	clearBackpackCargoGlobal _unit;
}
[_unit] call f_fnc_setGear;