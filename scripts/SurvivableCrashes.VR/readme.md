# Arma 3 Survivable Crashes  

**Author:** Rafael09ED

**Version:** 1.0

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

<a href="http://www.youtube.com/watch?feature=player_embedded&v=V9oBHfImjYk
" target="_blank"><img src="http://img.youtube.com/vi/V9oBHfImjYk/0.jpg" 
alt="Survivable Crashes" width="240" height="180" border="10" /></a>
