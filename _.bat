@echo off
cls
if exist %tmp%\apmbios.obj del %tmp%\apmbios.obj
if exist %tmp%\apmbios.map del %tmp%\apmbios.map
if exist %tmp%\apmbios.sys del %tmp%\apmbios.sys
c:\bp\bin\tasm /dOS2 /t /oi /m /ml apmbios.tas %tmp%\apmbios.obj > err.pas
type err.pas
if not exist %tmp%\apmbios.obj goto fehler
link /NoLogo /Map %tmp%\apmbios.obj,%tmp%\apmbios.sys,%tmp%\apmbios.map,,apmbios.def
if not exist %tmp%\apmbios.sys goto fehler
call nelite %tmp%\apmbios.sys apmbios.vk\boot\apmbios.sys /s > nul
del %tmp%\apmbios.obj
call mapsym %tmp%\apmbios.map apmbios.vk\boot\apmbios.sym > nul 2>&1
if exist %tmp%\apmbios.sym copy %tmp%\apmbios.sym apmbios.vk\boot\apmbios.sym
if exist %tmp%\apmbios.sym del  %tmp%\apmbios.sym
if exist     .\apmbios.sym copy     .\apmbios.sym apmbios.vk\boot\apmbios.sym
if exist     .\apmbios.sym del      .\apmbios.sym

if exist e:\os2\boot\apmbios.sys copy apmbios.vk\boot\apmbios.sys e:\os2\boot\apmbios.sys
if exist e:\os2\boot\apmbios.sym copy apmbios.vk\boot\apmbios.sym e:\os2\boot\apmbios.sym
goto ende

:fehler
echo Fehler (%0)
pause

:ende