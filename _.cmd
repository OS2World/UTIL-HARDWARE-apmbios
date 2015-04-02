@echo off
cls
call stampdef apmbios.def
SET DOSSETTING.DPMI_DOS_API=ENABLED
call _.bat
call noea apmbios.vk\* /r
call ..\genvk apmbios
cd apmbios.vk
call genpgp
cd ..