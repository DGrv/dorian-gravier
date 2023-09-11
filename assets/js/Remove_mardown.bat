SetLocal EnableDelayedExpansion
@echo off

cd node_modules

for /r %%i in ("*md", "*markdown") do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
	set check=!filenamenoext:~0,1!
	if "!check!"=="." (
		echo "%%i" in "%%~nxi"
		rename "%%i" "%%~dpi.%%~nxi"
	)
)
