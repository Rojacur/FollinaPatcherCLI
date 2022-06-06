@ECHO OFF

REM Author : Romain JAMIN
REM Date : 06/06/2022

ECHO Disabling MSDT URL protocol (CVE-2022-30190 - Follina)
ECHO Source : https://msrc-blog.microsoft.com/2022/05/30/guidance-for-cve-2022-30190-microsoft-support-diagnostic-tool-vulnerability/
ECHO.

SET "RegBckFileName=%tmp%\ms-msdt-CVE-2022-30190~%RANDOM%%RANDOM%.reg"
SET "RegKey=HKEY_CLASSES_ROOT\ms-msdt"

REM Chek if workaround is already applied
REG QUERY %RegKey% >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (

	ECHO Workaround is already applied.
	SET %ERRORLEVEL% = 0

) ELSE (
	
	ECHO Backing up registry key to %RegBckFileName% :
	REG EXPORT HKEY_CLASSES_ROOT\ms-msdt %RegBckFileName%
	ECHO.
	
	IF %ERRORLEVEL% NEQ 0 (
	
		ECHO Operation failed.
		
	) ELSE (
		
		ECHO Deleting registry key %RegKey%
		REG DELETE HKEY_CLASSES_ROOT\ms-msdt /f					
	)
)