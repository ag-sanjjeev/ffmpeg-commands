@echo off

rem Replace Source folder
set "source_folder=D:\media\source_directory"

rem Replace Output folder
set "output_folder=D:\output_directory"

rem Loop

for /D %%I in ("%source_folder%\*") do (

	echo subfolder: %%~nxI

	rem Create corresponding folder

	if not exist "%output_folder%\%%~nxI\%%~nxF" (

		if not exist "%output_folder%\%%~nxI" (
			
			mkdir "%output_folder%\%%~nxI"

			for %%F in ("%%I\*") do (

				rem convert
				rem ffmpeg -i "%%F" -c copy -vn "%output_folder%\%%~nxI\%%~nxF"
				rem ffmpeg -i "%%F" -c:a libmp3lame -b:a 128k -ac 2 -ar 44100 -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
				rem ffmpeg -i "%%F" -c:a libmp3lame -b:a 320k -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
				rem ffmpeg -i "%%F" -c:a copy -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
				
				ffmpeg -i "%%F" -c:a libmp3lame -b:a 128k -ar 44100 -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
				
				echo Filename: %%~nxF converted	
				rem echo %%F						
			)

		)
	)

)

echo Conversion Complete!

pause