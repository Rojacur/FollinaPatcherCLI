@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM Author : Romain JAMIN
REM Date : 07/06/2022

ECHO.
ECHO Disabling MSDT and Search URL protocol (CVE-2022-30190 - Follina + SearchNightmare)
ECHO Source : https://msrc-blog.microsoft.com/2022/05/30/guidance-for-cve-2022-30190-microsoft-support-diagnostic-tool-vulnerability/
ECHO.

SET Error=0

FOR %%x IN (
	ms-msdt
	search-ms
	
) DO (				
	
	ECHO [%%x]
	SET RegBckFileName=%tmp%\%%x~%RANDOM%%RANDOM%.reg
	SET RegKey=HKEY_CLASSES_ROOT\%%x
	
	REM Chek if workaround is already applied
	REG QUERY !RegKey! >nul 2>&1

	IF !ERRORLEVEL! NEQ 0 (

		ECHO Workaround is already applied.
		SET !ERRORLEVEL! = 0

	) ELSE (

		ECHO Backing up registry key to !RegBckFileName! :
		REG EXPORT !RegKey! !RegBckFileName!
		ECHO.

		IF !ERRORLEVEL! NEQ 0 (

			SET Error=1

		) ELSE (

			ECHO Deleting registry key !RegKey!
			REG DELETE !RegKey! /f
			
			IF !ERRORLEVEL! NEQ 0 (SET Error=1)
		)
	)
	
	ECHO.
)

IF !Error! EQU 1 (

	SET !ERRORLEVEL! = 0
	ECHO Operation failed.
)