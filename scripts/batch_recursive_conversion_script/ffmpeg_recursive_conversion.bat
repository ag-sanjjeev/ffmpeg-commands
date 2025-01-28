@echo off

rem This is Batch Script for converting from one media type to another media type
rem Here, the output media type is taken as .mp3 audio file 
rem This will convert without change in filename, foldername, any quality loss, sampling rate and channel loss.
rem This will search recursively throughout the source folder
rem This will works for folder structure as Main folder => subfolder 1 => files ...
rem Other kind of folder structure this will not work or need to change iteration logic.

rem Replace Source folder
set "source_folder=D:\media\source_directory"

rem Replace Output folder
set "output_folder=D:\output_directory"

rem Iteration for source folder

for /D %%I in ("%source_folder%\*") do (

	echo subfolder: %%~nxI

	rem This will not proceed if the folder already exist in the output folder

	if not exist "%output_folder%\%%~nxI" (

		rem Creates the corresponding folder name inside the output folder
		
		mkdir "%output_folder%\%%~nxI"

		rem Iterate through each and every files inside source folder

		for %%F in ("%%I\*") do (


			rem This is the ffmpeg command to convert into .mp3 audio file
			ffmpeg -i "%%F" -c:a libmp3lame -qscale:a 0 -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
			
			rem -i "%%F" is input file, -c:a libmp3lame is mp3 encoder commonly used.
			rem -qscale:a 0 is bitrate scale based on index which starts from 0 to 5, 0 - highest & 5 - least bitrate.
			rem -vn no video processing, -map_metadata 0 -id3v2_version 3 for copy meta_tags of mp3 file to converted file.
			rem Finally the output file with destination folder -> subfolder => file with extension
			
			rem Check and try to execute the command below if the above command produce large size output
			rem ffmpeg -i "%%F" -c copy -vn "%output_folder%\%%~nxI\%%~nxF"
			rem ffmpeg -i "%%F" -c:a libmp3lame -b:a 128k -ac 2 -ar 44100 -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
			rem ffmpeg -i "%%F" -c:a libmp3lame -b:a 320k -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"
			rem ffmpeg -i "%%F" -c:a copy -vn -map_metadata 0 -id3v2_version 3 "%output_folder%\%%~nxI\%%~nxF"

			echo Filename: %%~nxF converted	
			rem echo %%F	

		)

	)

)

echo Conversion Complete!

rem This will wait for user input at last.
pause