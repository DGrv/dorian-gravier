---
layout: "post"
title: "Use Lua script in windows"
data: "2022-12-18 10:00"
comments_id: 57
---

How to use lua in windows:

- install lua from [luaforwindows](https://github.com/rjpcomputing/luaforwindows)
- put the lua.exe in your PATH

How to use [luarocks](https://luarocks.org/) package manager:

- [install it](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows)
- move it to your lua PATH
- to install a package:

```sh
luarocks install --lua-version=5.1 <package-name>

:: Or check the code to install on luarocks.org but do not forget the --lua-version=5.1 since luaforwindows is for the moment only for this version
```



