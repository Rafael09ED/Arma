// Interface from F3 - Folk ARPS Assign Gear Script to Template Gear Script
private ["_unit"];
_unit = _this select 1;
[_unit] spawn {
	params ["_unit"];
	waitUntil {
		missionNameSpace getVariable ["loadoutInitializationDone", false]
	};
	if(_unit isKindOf "Man") then {
		removeBackpack _unit;
		removeAllWeapons _unit;
		removeAllItemsWithMagazines _unit;
		removeAllAssignedItems _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeUniform _unit;
	} else {
		clearWeaponCargoGlobal _unit;
		clearMagazineCargoGlobal _unit;
		clearItemCargoGlobal _unit;
		clearBackpackCargoGlobal _unit;
	};
	[_unit] call f_fnc_setGear;
};