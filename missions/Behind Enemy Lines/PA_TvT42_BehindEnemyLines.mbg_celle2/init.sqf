enableSaving [false, false];
enableSentences false;
[] execVM "f\safeStart\f_safeStart.sqf";
_location = createLocation ["NameCityCapital", getMarkerPos "respawn_west", 250, 250];
_location setText "Blufor Base";
_location = createLocation ["NameCityCapital", getMarkerPos "respawn_east", 250, 250];
_location setText "Opfor Base";

[] execVM "f\pilot\introShot.sqf";
[] execVM "r0ed_SurvivableCrashes\init.sqf"