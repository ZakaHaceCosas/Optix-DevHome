# Optix-DevHome
"*Development just has to be connected*"
---
The objective of Optix DevHome is to create a simple but powerful solution for both solo developers & team developers, built on top of the **Lua** programming language.

What to implement:
> (**Bold** = Implemented / ***Bold + Italic*** = Implemented and tested / Normal = Non implemented / Working on it):

- **Connect to remote Git repositories and clone them onto user's selected location.**
    - Remember Git URL
- Send PRs, commits, and more.
- Implement Projects
    - Project setups
    > Project setups are a way to speed up workflows: you click once, and all the programs you need are open and all the libraries & dependencies you need get updated and installed if needed. (That's the idea tho)
    - Project files
    - Project sharing
- GUI
    - Multiple languages
    > *Note: Optix DevHome will be first developed in spanish, then ported to english, and after that we'll see. This isn't a priority for now.*

### Documentation
You will need to install Lua to work on this project. For now it's not using any library.

Don't have Lua? Here's the command for major Linux systems, macOS, and Windows.
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
- **macOS**
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install lua
```
- **Windows**

Just get it from [Lua's website](https://lua.org/download.html)

---
Ok, you're ready. Files are commented for you to easily get what does each line do. Just do your nice contribution, and when you're done, make a ***Pull Request***. Don't forget to comment your code and/or changes aswell.

For easier navigation, some comments have keywords (for when you use search in VSCode or your preference IDE).

`ERR` - That line isn't doing what it should and it's breaking the program.

`WARN` - That line isn't doing what it should, but the rest of the program can run properly.

`NOTE` - Things that are undone or that will be changed.

---
You want to preview your changes? Hit Save on your IDE, open up a terminal, and run
```bash
lua main.lua
```
It will run instantly so you can try it. No compiling, waiting, or anything like that. It's Lua.

---
Well, that's it! You're now ready to write some fancy code on this project. Have fun and thanks for contributing!
