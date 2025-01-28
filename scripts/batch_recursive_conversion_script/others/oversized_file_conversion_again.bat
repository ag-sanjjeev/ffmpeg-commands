@echo off

rem This script compares and creates another batch script for over sized files.
rem That created batch script has command that delete existing converted files and reconvert again.
rem This is need for dynamic value assigned to the variable for Batch script

setlocal enabledelayedexpansion

rem Replace source folder
set "source_folder=D:\media\source_directory"

rem Replace output folder
set "output_folder=D:\output_directory"

rem Destination file path for Batch Script
set "conversion_bat=D:\reconversion_ffmpeg.bat"

echo Starts Comparing 

echo "!source_folder!"

echo with

echo "!output_folder!"

rem Starting writing Batch Script Code
echo @echo off > "%conversion_bat%"

rem Iterate through all subfolders inside source folder at one level

for /R "%source_folder%" %%F in (*) do (

	rem Assiging source file size, file name, relative path
	set "size1=%%~zF"
	set "file1=%%~nxF"
	set "relpath=%%~dpF"
	set "relpath=!relpath:%source_folder%=!"

	rem echo "!output_folder!!relpath!!file1!", "!size1!"

	rem Checks & Proceeds if the file exist in the name of input file
	if exist "!output_folder!!relpath!!file1!" (

		rem Assigning output file size
		for %%G in ("!output_folder!!relpath!!file1!") do set "size2=%%~zG"

		rem set /a "diff=!size2!-!size1!"

		rem Assiging output file size in the percentage with input file
		set /a "diff=(100 * size2 / size1)"

		rem echo !diff!, !size1!, !size2!

		rem Check & Proceeds if the file size is more than 140% of the input file
		if !diff! gtr 140 (

			rem Converting file size in the form Mega Bytes for readable.
			set /a "size1_mb=!size1!/1048576"
			set /a "size2_mb=!size2!/1048576"

			rem echo Source File: "!relpath!  !file1!"

			rem echo Source File: "!relpath!  !file1!", "Source:", !size1_mb! mb, "Destination:", !size2_mb! mb >> "!report!"
			rem echo Source File: "!source_folder!!relpath!!file1!", "Source:", !size1_mb! mb, "Destination:", !size2_mb! mb >> "report.txt"
			rem echo Destinate File: "!output_folder!!relpath!!file1!", !size1! bytes >> "!outputFile!"
			
			rem Writing Delete Command for oversized converted file to delete. If exist. 
			if exist "!output_folder!!relpath!!file1!" (
				echo del "!output_folder!!relpath!!file1!" >> "%conversion_bat%"
				
				rem Displays after that oversized file deleted
				echo echo file deleted >> "%conversion_bat%"
			)

			rem If the file was manually deleted then or deleted by above command then starts here
			echo echo conversion starts again >> "%conversion_bat%"

			rem Converting the input file again to respective destination path with same name and near in file size.
			echo ffmpeg -i "!source_folder!!relpath!!file1!" -c:a libmp3lame -qscale:a 4 -vn -map_metadata 0 -id3v2_version 3 "!output_folder!!relpath!!file1!" >> "%conversion_bat%"
			
			rem Displays after the conversion completes.
			echo echo conversion complete >> "%conversion_bat%"
		)


	)

)

rem Displays overall process gets complete.
echo echo Completed >> "%conversion_bat%"

rem Adds user input at the end of the Batch Script.
echo pause >> "%conversion_bat%"

rem Wait for user input for this script.
pause