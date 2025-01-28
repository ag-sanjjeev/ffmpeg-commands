# Mp3Tag Tool

This is a software that can be used to manipulate tags associated with audio files. This file contains useful examples with `mp3tag` tool.

## Remove Specific String From Filename:

Consider, an example filename: `this-is-an-sample-audio.ExternalSite.com.mp3`. To remove `externalsite.com` from the file name then follow below steps:
1. Open `Mp3Tag` tool,
2. Load or Browse the file where it is located.
3. After load, then select that file by click or navigate to that.
4. Choose options from top bar `quick actions => replace with regex` 
5. Choose the `FILENAME` option and enter the regular expression `\bExternalSite\.com\b`
6. Click `replace`.

Similarly for the filename contains:
1. Whitespace then use `\ \.`
2. Leading brackets `(` then use `\(`.
3. Trailing brackets `)` then use `\)`.
4. Leading square brackets `[` then use `\[`.
5. Trailing square brackets `[` then use `\]`
6. Double Dots or Double Period `.` then use `\.\.`

## Filter Files Based On Directory Name:

- This will load files from that parent directory contains subdirectory their name ending with 4 digit numbers.

`NOT %_directory% MATCHES ".*\b\d{4}$"`

## Update Year tag:

To update year tag for file from their directory name, which has year at end of the name.

Follow the steps:

`actions -> action group -> new action -> format value -> 
in field -> choose year, in format string -> $right(%_directory%,4)`

## Remove Year From Directory Name:

To remove year from directory name, follow the steps:

- Use `step 1` for create action.
- Choose `regex replace` option.
- Paste the regex in the first field of input `(?<=\D)\d{4}$` Which denotes last four digit.
- then replace with empty.

For first four digit year, then use `^[0-9]{4}`.

## Update Year To The Front Of Directory Name:

Use quick action, choose regex replace option. To replace directory name with this notation `%year% %_directory%`.