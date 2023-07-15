# Optix DevHome CHANGELOG
Every update is logged here.
## Version 0.0.6
---
- Refactor of the GUI
- (Unsuccessful) attemps to implement project opening
- Aditional changes to codebase
- Upload of logo and favicon
## Version 0.0.5
---
- Succesfully implemented .optixData parsing (now need to add a function)
- Upload of `windows.lua`, GTK based GUI version of Optix DevHome. **Needs reviewing**.
## Version 0.0.4
---
- Finally, HALF implementation of the .optixData parser
- Renamed some variables
- Optimised the code
- Some works to UX
- - Creation of a home menu
- - Added `about` command (Soon also a `help` command)
- - Now prompts are colored to create visual meaning
- Optimised .optixData files
- Added the GUI-mode option (currently not working as `windows.lua` will wait for version `0.0.5`)
- Added an ASCII on startup. Because, why not?
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