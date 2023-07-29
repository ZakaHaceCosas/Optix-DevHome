# Optix DevHub
"*Development just has to be connected*"
---
> Recently renamed from **DevHome** to **DevHub**

> Soon moving docs to the [official website](https://optix.rf.gd/apps/devhub/) aswell
## About

The objective of Optix DevHub is to create a simple but powerful solution for both solo developers & team developers, built on top of the **Lua** programming language.

## What to implement:

- [X] Connect to remote Git repositories and clone them onto user's selected location.
- [ ] Send PRs, commits, and more.
- [ ] Implement Projects
    - [X] Basic Project saving
        - Advanced Project saving
            - [ ] Project setups
            > Project setups are a way to speed up workflows: you click once, and all the programs you need are open and all the libraries & dependencies you need get updated and installed if needed. (That's the idea tho)
            - [X] Project files
            - [X] Project updating
                - [ ] Secure project updating
            - [ ] Project sharing
- [ ] Multiple languages
> *Note: Optix DevHub will be first developed in spanish, then ported to english, and after that we'll see. This isn't a priority for now.*
- [ ] GUI
    - [ ] GUI based on the Umbra design system (Link to Figma (very) soon)

## Documentation

### Set up

You will need to install Lua to work on this project. Also you will need the Luarocks Package Manager to install the libraries we use.
Libraries:
- LuaSocket
- RapidJSON
- LuaFileSystem

### Install Lua 5.3
- **Debian or Ubuntu**
```bash
sudo apt-get install lua5.3
```
- **Fedora or CentOS**
```bash
sudo dnf install lua
```
- **Arch**
```bash
sudo pacman -S lua
```
- **Windows**

Just get it from [Lua's website](https://lua.org/download.html)

> Note DevHub is not supported on macOS as of now, so code won't work properly on Apple devices.

After that, install [the Luarocks package manager](https://luarocks.org), and install the following packages:
```bash
(sudo) luarocks install luasocket
```
```bash
(sudo) luarocks install rapidjson
```
```bash
(sudo) luarocks install lgi
```
```bash
(sudo) luarocks install luafilesystem
```
For info:
- LuaSocket: For HTTP requests (for coming soon features...)
- RapidJSON: JSON encoding and decoding (for project data)
- LGI: GTK for Lua (for GUI version)
- LuaFileSystem: LFS is a library for easier access to users file system (for project data)

## Editing

Ok, you're ready. How do you write *fancy* code on this project?

1. Use `local` variables almost always
That way we can avoid naming issues

**Do:**
```
local Bread = "I like bread"
print(Bread)
```
**Don't**
```
Bread = "I like bread"
print(Bread)
```

2. When naming variables, be very specific
At the end we may have too many variables, so be specific with the naming.
However, don't write TheEntireSentenceLikeThis.

**Do:**
```
local Icon32PNG = "/img/icon-32.png"
local UserConfirmRemoveProject = "Do you want to remove this project?"
local Game1ExeFile = "/home/pico/game1.exe"
```
**Don't:**
```
local icon = "/img/icon-32.png"
local question = "Do you want to remove this project?"
local game = "/home/pico/game.exe"
```

3. Comment errors correctly
For parts that don't work, add a comment using the ERR, WARN, NOTE system:

`ERR` - That line isn't doing what it should and it's breaking the program.

`WARN` - That line isn't doing what it should, but the rest of the program can run properly.

`NOTE` - Things that are undone or that should (or will) be changed.

Write things nicely and briefly.

**Do:**
```
-- ERR: after replying it returns an error and stops the program
UserFavouriteFood = readInput("Whats your favourite food?")
if UserFavouriteFood = "bread"
    print("you like bread? me too!")
```
4. Make ***Pull Requests***, never Direct Commits. Thanks :]

## Testing

Open up a terminal. It will probably open on the source directory. Enter the `src` directory:
```bash
cd src
```

Then run the following command:
```bash
lua main.lua
```

Just like that, the program will run on the terminal, ready to test.
(Note: You *must* be on the `src` directory from the terminal before running, or else Lua will return that `config.lua` wasn't found.)


Well, that's it! You're now ready to write some fancy code on this project. Have fun and thanks for contributing!

## Acknowledgments

Contributors:
- For now I am the only one working on this project, so...

OSS used:
<!--this is actually here because it needs to be: i just noticed Lua required this for it's usage XD
they deserve it tho, lua is just so cool-->
- A shoutout to the amazing team who created the Lua programming language, at PUC-Rio (Lua.org).

Copyright &copy; 1994–2023 Lua.org, PUC-Rio.
