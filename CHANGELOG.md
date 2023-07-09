# Optix DevHome CHANGELOG
Every update is logged here. Updates that don't make significant changes, or don't fully implement anything, won't be logged.
## Version 0.0.3
---
- Implemented a main menu
- Fixed a bug that messed up the default project location
- Changed our "custom format", now it is .optixData
- [Non working yet] Attemp to parse .optixData files, so Lua can understand it's structure.
- Changed the default folder from dhr- (DevHome Repo) to dhp- (DevHome Project)
- Renamed some variables to avoid naming problems
- Refactored (again) the code, by making it even more modular.

## Version 0.0.2
---
- Successfully implemented project saving, currently in (user_dir)/OptixDevHome/projects.OPTdhData
- Organised the code by using some global variables in config.lua. (Note: local variables are still highly recommended.)

## Version 0.0.1 - Released 08/07/2023
---
- First actual PR!
- Implemented Git cloning and directory creating