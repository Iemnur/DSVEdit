; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "DSVania Randomizer x64"
#define MyAppVersion "0.0.1"
#define MyAppExeName "DSVRandom_x64.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{FA3C4D50-6666-4FD9-8427-8C1833B8E0E0}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
DefaultDirName={src}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=../build
OutputBaseFilename=dsvrandom-installer-x64
Compression=none
SolidCompression=no
Uninstallable=no
