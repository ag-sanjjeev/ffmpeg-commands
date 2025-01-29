@echo off

rem This is Batch script for comparing the converted files with input files based on file size.
rem Here, the converted file over the size than input file of above 140 %, Then it will note it down.
rem This script works based on dynamic value assigned to the variable for Batch script

setlocal enabledelayedexpansion

rem Replace source folder
set "dir1=D:\media\source_directory"

rem Replace destination folder
set "dir2=D:\output_directory"

rem Replace report want to be stored
set "report=D:\report.txt"

echo Starts Comparing 

echo "!dir1!"

echo with

echo "!dir2!"

rem Iterate through all subfolders inside source folder at one level

for /R "%dir1%" %%F in (*) do (

	rem Assiging source file size, file name, relative path
	set "size1=%%~zF"
	set "file1=%%~nxF"
	set "relpath=%%~dpF"
	set "relpath=!relpath:%dir1%=!"

	rem echo "!dir2!!relpath!!file1!", "!size1!"

	rem Checks and Proceeds if the file exist in the name of input file
	if exist "!dir2!!relpath!!file1!" (

		rem Assigning output file size
		for %%G in ("!dir2!!relpath!!file1!") do set "size2=%%~zG"

		rem Assigning output file size in the percentage with input file size
		set /a "diff=(100 * size2 / size1)"

		rem echo !diff!, !size1!, !size2!

		rem Check and Proceeds if the output file size is more than 140% of the input file size
		if !diff! gtr 140 (

			rem Converting file size in the form Mega Bytes for readable.
			set /a "size1_mb=!size1!/1048576"
			set /a "size2_mb=!size2!/1048576"

			echo Source File: "!relpath!  !file1!"

			rem Display and Saves the details of over sized converted files with their file sizes
			echo Source File: "!relpath!  !file1!", "Source:", !size1_mb! mb, "Destination:", !size2_mb! mb >> "!report!"
			
			rem echo Source File: "!dir1!!relpath!!file1!", "Source:", !size1_mb! mb, "Destination:", !size2_mb! mb >> "report.txt"
			rem echo Destinate File: "!dir2!!relpath!!file1!", !size1! bytes >> "!outputFile!"


		)


	)

)

echo Comparison Complete!

rem This will wait for user input at last.
pause