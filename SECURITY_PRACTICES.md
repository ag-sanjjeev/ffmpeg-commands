# Security Practices:

Consider following step for copied or downloaded media from unknown source:

## Step 1: 

* Before copy or downloading check file extension.
* Scan for any viruses and Malwares.
* Compare anti-virus scan count during or after the scan for those files.
* Check for any secret Data Stream attached to those file

## Step 2:
 
* Consider to remove all album arts, thumbnails and hidden data stream for the those media.
* Check and Remove any hidden album arts and thumbnails inside the parent directory of the files.
* Consider to remove all tags associated with that file using `mp3tag tool`.
* Re-assign the tags as per the need with `mp3tag tool`.

## Step 3: (optional)

* Consider if need to convert from those media to higher possible quality.
* When convert avoid lossless quality, sampling rate and channel loss with `FFMPEG` or any other tools.
* Check for any over sized converted output files.
* Re-convert with light adjustments to the quality parameters.

---

## Discover Hidden Files:

**Show any other hidden files in a directory and sub directory**

```cmd
dir /A:H /S
```

Even-though, Enabling show hidden files option. If hidden files doesn't show for above commands then try following command for specific file.

**Discover any hidden files that not shown:**

```cmd
attrib -h -s -r Filename.extension
```

- Check for any hidden stream in the file

```cmd
dir /r
```

- for throughout subdirectory

```cmd
dir /r /s
```

**Check for files with any data streams in the current directory:**

```cmd
dir /r | findstr /e ":$DATA"
```

- for throughout subdirectory

```cmd
dir /r /s | findstr /e ":$DATA"
```
