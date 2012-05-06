@echo off

C:
chdir C:\cygwin\bin

:: Sometimes needed (Win7)
:::set HOME=c:/cygwin/home/bheckel

:::bash --login -i

start /B rxvt.exe -geometry 80x25 -fn "terminal-13" -sl 10000 -sr -bg black -fg #F5DEB3 -e /bin/bash --login -i
