#define _ARMA_
class DefaultEventhandlers;
class CfgPatches 
{ 
    class r0ed_SurvivableCrashes
    { 
        units[] = {"r0ed_ModuleSurvivableCrashes"}; 
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Modules_F"}; 
		projectName = "Survivable Crashes";
		author = "Rafael09ED";
    }; 
};
class CfgFactionClasses
{
	class NO_CATEGORY;
	class r0ed_SurvivableCrashes: NO_CATEGORY
	{
		displayName = "Survivable Crashes";
	};
};
class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class ArgumentsBaseUnits{};
		class ModuleDescription{};
	};
	class r0ed_ModuleSurvivableCrashes: Module_F
	{
		displayName = "Survivable Crashes Settings";
		author = "Rafael09ED";
		scope = 2; 
		category = "r0ed_SurvivableCrashes";
		function = "r0ed_fnc_moduleSurvivableCrashes";
		functionPriority = 5;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		is3DEN = 0;
		curatorInfoType = "RscDisplayAttributeSurvivableCrashes";
		class Arguments: ArgumentsBaseUnits
		{
			class ModEnabled
			{
				displayName = "Enable Mod";
				description = "Enables or Disables Survivable Crashes";
				typeName = "BOOL";
				class values {
					class enable {name = "Enabled"; value = true; default = 1;};
					class disable {name = "Disabled"; value = false;};
				};
			};
			class VisualEffects
			{
				displayName = "Visual Effects";
				description = "Visual Effects Toggle";
				typeName = "BOOL";
				class values {
					class vfxOn {name = "Enabled"; value = 1; default = 1;};
					class vfxOff {name = "Disabled"; value = 0;};
				};
			};
			class SoundEffects
			{
				displayName = "Sound Effects";
				description = "Sound Effects Toggle";
				typeName = "BOOL";
				class values {
					class sfxOn {name = "Enabled"; value = 1; default = 1;};
					class sfxOff {name = "Disabled"; value = 0;};
				};
			};
			class ExaggeratedEffects
			{
				displayName = "Exaggerate Effects";
				description = "Exaggerated Effects Toggle (Spawn Vehicle Fire, Impact Explosion)";
				typeName = "BOOL";
				class values {
					class ExagFxOn {name = "Enabled"; value = 1; default = 1;};
					class ExagFxOff {name = "Disabled"; value = 0;};
				};
			};
			class MedicalSystem
			{
				displayName = "Medical System";
				description = "Method for handling crew damage";
				typeName = "STRING";
				class values {
					class forceACE {name = "Force ACE3"; value = "ACE";};
					class forceVanilla {name = "Force Vanilla"; value = "VANILLA";};
					class autoDetect {name = "Auto Detect (ACE3 or Vanilla)"; value = "AUTO"; default = 3;};
					class applyNoDamage {name = "Allow Damage False Only"; value = "DAMAGEFALSE";};
					class doNothing {name = "Do Not Prevent Damage (Do Nothing)"; value = "NONE";};
				};
			};
			class CrewDamageMultiplier
			{
				displayName = "Crew Damage Multiplier";
				description = "Multiplier to the default damage applied to the crew after the crash(ACE and Vanilla)";
				defaultValue = "1";
			};
			class VehicleKindWhitelist
            {
            	displayName = "Vehicle Kind Whitelist";
            	description = "Whitelists CfgVehicles for Survivable Crashes";
            	defaultValue = "[""Air""]";
            };
			class CrewPostCrashCode
            {
                displayName = "Crew Post-Crash Code";
            	description = "Code called locally by each crew member after they are ejected: _this = [_unit]";
            	defaultValue = "params[""_unit""];";
            };
			class VehicleRestCode
			{
				displayName = "Vehicle Rest Code";
				description = "Code called after vehicle stops moving: _this = [vehicle, impact speed]";
				defaultValue = "params[""_veh""]; sleep (40 + random 40); _veh allowDamage true; _veh setDamage 1;";
			};
		};
		class ModuleDescription: ModuleDescription
		{
			description = "Settings for Survivable Crashes mod";
			sync[] = {}; 
		};
	};
};
class Extended_PostInit_EventHandlers {
    class r0ed_SurvivableCrashes_XEH_PostInit {
        init = "call compile preprocessFileLineNumbers '\r0ed_SurvivableCrashes\XEH_postInit.sqf'";
    };
};
class Extended_PreInit_EventHandlers {
    class r0ed_SurvivableCrashes_XEH_PreInit {
        init = "call compile preprocessFileLineNumbers '\r0ed_SurvivableCrashes\XEH_preInit.sqf'";
    };
};
class CfgFunctions 
{
	class r0ed
	{
		tag = "r0ed";
		class SurvivableCrashesInit
		{
		    file = "\r0ed_SurvivableCrashes\functions\init";
			class moduleSurvivableCrashes{};
		};
		class SurvivableCrashes
		{
			file = "\r0ed_SurvivableCrashes\functions";
			class vehicleCrashLocal{};
			class crashVisualEffects{};
		};
	};
};	
class CfgSounds {
	class AutorotationWarn
	{
		name = "AutorotationWarn";
		sound[]={"\r0ed_SurvivableCrashes\sounds\ACE_AutorotationWarning.ogg", 4, 1};
		titles[]={};
	};
};
class Extended_GetInMan_EventHandlers {
    class CAManBase {
        class r0ed_SurvivableCrashes_XEH_GetInMan {
            getInMan = "call compile preprocessFileLineNumbers '\r0ed_SurvivableCrashes\XEH_getInMan.sqf'";
        };
    };
};

// https://community.bistudio.com/wiki/Arma_3_Module_Framework
// https://forums.bistudio.com/topic/184230-error-with-making-a-module/?p=2904848