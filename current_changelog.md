For more information, read here: https://github.com/nihil92/Core-Framework/blob/main/DOCUMENTATION.md

**0.28.0 - In Progress**
- Blue Spheres' Special Stage, taken from Discovery Framework.
- Fixed bugs with the FlipAngle object that weren't working.
- An exciting array of new badniks has been introduced, including Mosqui, Catterkiller Jr., Dragonfly, Poh Bee, Sweep, Bombbearer, Jaws, Clucker and Mantis.
- The plane launchers from the Flying Battery Zone have been added.
- Reintroduced the burnable bridge, which was present in private versions.
- Implemented the inverted monitors gadget (with mirroring shader).
- Removed Group.Masks (Trees) that were previously used to move monitors to the back of the trees. Now the trees work using the "BackLayer" object instead.
- The ring system has been adjusted to allow the creation through any object within the X and Y position. An example of its use has been included in the Bombbearer code.
- Implemented temporary values for PosX, PosY, SpX, and SpY, which are used to store values temporarily for flexible usage. With this update, we have remade the "DestroyEnemy" fast loop, as it became necessary due to the recent edits made in the monitor code.
- Remade the monitor fragment code.
- The trail system has been reworked, and now it uses the character's own skin without the need for a new object for it. This will make editing much more easier, because previously if you made changes to the character's skin, you had to make the same changes to the trail object as well.
- Flying Battery Zone mines have been added. 
**The explosions have been completely overhauled, here is the changes:**
- A new state has been included for explosions, allowing them to harm the player if they are created with ``State = 4``. This change was mainly implemented for the mines, but it can have various applications beyond that.
- Now, Flickies can be created through any explosion, as long as the Flicky variable is set to 1.
- The RumbleState variable has been removed due to its disuse or lack of necessity.
- The explosion sprites were incorrect, but they have now been fixed.
- Some revisions have been made to the oil stream (or oil waterfall?) to make it more enjoyable to play and also to fix some bugs.
- Now, the life icon uses the same glowing effect as the superforms (using shaders). Some sprites had incorrect colors, but they have now been fixed.
- The Layer Switches (of the Loopings) have been redone, especially those that are in the middle (0/1), to prevent a bug. Additionally, a correction has been made to the order of the inputs and outputs. This correction was present in a version of the Core made for Sonic ATS'23.
- The semi-solids have been redone again, and now they support slopes without needing to be anchored to the collision hotspot where it starts (as requested by Angelos).
- New: Platform Spring from CPZ.
- A _scanline_ mode was been introduced.
- The water pools was been restored in this new version.
- Major fixes on Amy's Hammer and the addition of a hitbox for it.
- Major fixes on HitboxSensor.
- Introduced the use of InstanceValues, the only value that can be changed PER OBJECT in the Frame Editor individually. This feature is available in newer versions of Clickteam Fusion. For this reason, the Scope Control extension has been removed. 
- Cancel the spindash if the player falls off the ledges.
- ABC inputs (Genesis-like) are implemented.
- The Control Lock is now reset in mid-air.
- Updated physics (acceleration, deceleration, and friction). The physics now feel less heavy and more accurate.
- Implemented an accurate rebound method for enemies and monitors.

**Still planned features?**

- Anti-Gravity Gadget.
- Barells (from CNZ).
- CPZ Tunnels.
- Delta Time.

**[!!!] Release Notes:**
- Whenever it's necessary to refer to the primary skin (i.e., the one that is not a trail), always remember to use ID = 0.