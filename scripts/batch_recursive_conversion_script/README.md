# Batch Conversion Script

This script will convert from one media files to another media file recursively under all subfolders and files.

## &#9873; Consider Following Steps:

1. Inspect the code completely.
2. Update `source_folder` and `output_folder` in the code.
3. `source_folder` is the directory, which must contain media files that to be converted.
4. `output_folder` is the directory, where the converted media files will be moved in it.
5. This will suitable for the directory structure as `source_folder => subfolders ... => files ...`.
6. The `source_folder` might has number of `subfolders` and each of the `subfolders` might has media files that need to be converted.
7. This script will iterate through all files inside `subfolders` in the specified `source_folder`.
8. If your `source_folder` has different folder structure, then adjust the execution logic at your own risk.
9. Look for alternative commands provide inside the script, if the output is not desired in size.
10. For demonstration, Convert to `.mp3` audio file commands has used.
11. After completion of the conversion. It will wait for user input. That you have to press any key to close the script after completion.
12. To skip/stop conversion for the current conversion file, It might required `q` in your keyboard to be pressed or read command help during execution.

Note: 

- Here, for an example, The command uses flag `-map_metadata 0` to exclude the meta data from the source files.
- Here, `-qscale:a` ranges from `0 - 5`, `0` - highest bit rate, `5`-low bps.

**For recursive conversion, Consider `ffmpeg_recursive_conversion.bat` and follow above steps.**

To compare your converted files in different aspect then refer [File Comparison Script](../file_comparison_script/README.md)

## &#9873; Others

Note: *Others directory scripts are created for different purpose. Review the code before proceed. This is separate batch script and not related with `ffmpeg_recursive_conversion.bat`.*

This directory contains `oversized_file_conversion_again.bat` and `ffmpeg_128kbps_conversion.bat`. Refer the commands and script before proceed. 
- `oversized_file_conversion_again.bat` file:
	- This script compares and creates another batch script for over sized converted files.
	- This will create another batch script, which has commands that delete over sized existing converted files and reconvert again.
- `ffmpeg_128kbps_conversion.bat` file:
	- This is an example script that convert media files into `.mp3` files
	- It converts files with fixed bit-rates of 128kbps.

## &#9873; Disclaimer

This is a repository contains few of the commands used related to FFMPEG. That can be useful to convert media files in your computer/device. Be caution, the author shall not be responsible for any warranty or claim to any malfunctions or lose arise from these commands and scripts. Make a backup your files before proceed. Consult with experts and double check before proceed with it. Use this commands and scripts at your own risk.

## &#9873; License

This project licensed under the [MIT license](../../LICENSE). Feel free to use, modify, and distribute it as per the terms of the license.
