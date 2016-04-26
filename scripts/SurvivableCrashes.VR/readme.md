# Arma 3 Survivable Crashes  

**Author:** Rafael09ED

**Version:** 1.0

Allows the crew of a vehicle to survive it's destruction and escape harmed. Damage is added through ACE, making it a dependency.

### Installation:

1. Copy the folder "f" and the folder "sounds" to the mission directory
2. Merge the description.ext file to the one in your mission directory
3. Put the following code in the init of each vehicle you want it applied to:

```sqf
    0 = [this] execVM "f\crash\fn_handleDamage_NoExplode.sqf";
```


### Dependencies: 

- ACE3


### Video:

https://www.youtube.com/watch?v=V9oBHfImjYk

