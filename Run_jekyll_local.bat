@echo off

echo Check Internet connection ---------------------------
echo.

:: Ping Google to check for an internet connection

REM ping -n 1 google.com >nul 2>&1
REM if %errorlevel%==0 (
	REM echo Internet available: Using remote theme.
	REM perl -pe "s/^theme\:/# theme\:/" -i _config.yml
	REM perl -pe "s/^# remote_theme\:/remote_theme:/" -i  _config.yml
REM ) else (
	REM echo No internet: Using local theme.
	REM perl -pe "s/^remote_theme\:/# remote_theme:/" -i _config.yml
	REM perl -pe "s/^# theme\:/theme:/" -i _config.yml
REM )
REM echo Theme configuration updated in _config.yml.

echo.

bundle exec jekyll serve
REM bundle exec jekyll serve --incremental


REM Incremental building can sometimes cause issues if you're adding new files or making structural changes (like adding new pages or collections). In such cases, a full rebuild might be required.
REM It works best for content changes like editing blog posts or pages, not structural changes to the site.