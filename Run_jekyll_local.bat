@echo off

:: Ping Google to check for an internet connection
echo [33mCheck Internet connection ---------------------------[37m
ping -n 1 google.com >nul 2>&1
if %errorlevel%==0 (
	echo [32mInternet available: Using remote theme.[37m
	perl -pe "s/^theme\:/# theme\:/" -i _config.yml
	perl -pe "s/^# remote_theme\:/remote_theme:/" -i  _config.yml
) else (
	echo [31mNo internet: Using local theme.[37m
	perl -pe "s/^remote_theme\:/# remote_theme:/" -i _config.yml
	perl -pe "s/^# theme\:/theme:/" -i _config.yml
)
echo [33mTheme configuration updated in _config.yml.[37m

echo.

bundle exec jekyll serve
REM bundle exec jekyll serve --incremental

REM --baseurl="" if locally 
REM --baseurl="" if locally 
REM --baseurl="" if locally 
REM --baseurl="" if locally 
REM --baseurl="" if locally 

REM Incremental building can sometimes cause issues if you're adding new files or making structural changes (like adding new pages or collections). In such cases, a full rebuild might be required.
REM It works best for content changes like editing blog posts or pages, not structural changes to the site.