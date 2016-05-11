// Briefing for admin tools

_briefing ="
<br/>
<font size='18'>ADMIN SECTION</font><br/>
This briefing section can only be seen by the current admin.
Please use responsibly.
<br/><br/>
";

// ENDINGS

_title = [];
_ending = [];
_endings = [];

_i = 1;
while {true} do {
	_title = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "title");
	_description = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "description");
	if (_title == "") exitWith {};
	_ending = [_i,_title,_description];
	_endings append ([_ending]);
	_i = _i + 1;
};

// display endings

_briefing = _briefing + "
<font size='18'>ENDINGS</font><br/>
These endings are available. To trigger an ending click on its link.<br/><br/>
";

{
	_end = _this select 0;
	_briefing = _briefing + format [
	"<execute expression="" 'end%1' call BIS_fnc_endMission;"">'end%1'</execute> - %2:<br/>
	%3<br/><br/>"
	,_x select 0,_x select 1,_x select 2];
} forEach _endings;

// SAFE START

_briefing = _briefing + "
<font size='18'>SAFE START CONTROL</font><br/>
|- <execute expression=""f_var_mission_timer = f_var_mission_timer + 1; publicVariable 'f_var_mission_timer'; hintsilent format ['Mission Timer: %1',f_var_mission_timer];"">
Increase Safe Start timer by 1 minute</execute><br/>

|- <execute expression=""f_var_mission_timer = f_var_mission_timer - 1; publicVariable 'f_var_mission_timer'; hintsilent format ['Mission Timer: %1',f_var_mission_timer];"">
Decrease Safe Start timer by 1 minute</execute><br/>

|- <execute expression=""[[[],'f\safeStart\f_safeStart.sqf'],'BIS_fnc_execVM',true]  call BIS_fnc_MP;
hintsilent 'Safe Start started!';"">
Begin Safe Start timer</execute><br/>

|- <execute expression=""f_var_mission_timer = -1; publicVariable 'f_var_mission_timer';
[['SafeStartMissionStarting',['Mission starting now!']],'bis_fnc_showNotification',true] call BIS_fnc_MP;
[[false],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safe Start ended!';"">
End Safe Start timer</execute><br/>

|- <execute expression=""[[true],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safety on!' "">
Force safety on for all players</execute><br/>

|- <execute expression=""[[false],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safety off!' "">
Force safety off for all players</execute><br/><br/>
";

// CREATE DIARY ENTRY

player createDiaryRecord ["diary", ["Admin",_briefing]];