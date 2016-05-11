scriptName "fn_triggerListChanged";
/*
	File:			fn_triggerListChanged.sqf
	Author:			Heeeere's Johnny!	<<< Please do not edit or remove this line. Thanks. >>>
	Version:		2.1
	Description:	Executes the given functions whenever the trigger's list changes.
					Inside the functions, the unit may be referred to as "_x" and the trigger as "_trigger".
	Execution:		call
	
	Parameters:
		0 OBJECT	_trigger			a trigger having at least an activation statement
		1 SCRIPT	_fnc_enteringUnits	the function to be execution for each entering unit
		2 SCRIPT	_fnc_leavingUnits	the function to be execution for each leaving unit
		3 BOOLEAN	_isCall				(default: false), if true, functions will be called, else spawned
	
	Return:
		OBJECT		_trigger			the "augmented" trigger
*/
//all defines are used to setVariable on the trigger - alter if in conflict with other scripts
#define THIS_LIST "thisList"
#define PREV_LIST "thisListPrev"
#define TOGGLE "toggle"

private ["_fnc_triggerListChanged", "_invoke", "_triggerFunction"];
params ["_trigger", ["_fnc_enteringUnits", {}, [{}]], ["_fnc_leavingUnits", {}, [{}]], ["_isCall", false, [true]]];

_fnc_triggerListChanged = format
["{
	private ['_trigger', '_thisList', '_thisListPrev'];
	_trigger		= _this;
	_thisList		= _trigger getVariable '%1';
	_thisListPrev	= _trigger getVariable '%2';
	
	%3 forEach (_thisList - _thisListPrev);	comment 'for each entering unit';
	%4 forEach (_thisListPrev - _thisList);	comment 'for each leaving unit';
}", THIS_LIST, PREV_LIST, _fnc_enteringUnits, _fnc_leavingUnits];

if(_isCall) then {_invoke = "call"} else {_invoke = "spawn"};

_triggerFunction = format ["thisTrigger %1 %2;", _invoke, _fnc_triggerListChanged];

_trigger setVariable [THIS_LIST, []];
_trigger setVariable [TOGGLE, false];
_trigger setTriggerStatements
[
	format ["
		isServer &&
		{
			comment 'if thisList changed compared to previous check, do stuff';
			if !(thisList isEqualTo (thisTrigger getVariable '%1')) then
			{
				comment 'set list of last check to thisListPrev and thisList to current list';
				thisTrigger setVariable ['%2', +(thisTrigger getVariable '%1')];
				thisTrigger setVariable ['%1', +thisList];
				
				comment 'toggle variable state';
				thisTrigger setVariable ['%3', !(thisTrigger getVariable '%3')];
			};
			thisTrigger getVariable '%3'
		}
	", THIS_LIST, PREV_LIST, TOGGLE],
	_triggerFunction,
	_triggerFunction
];

_trigger
