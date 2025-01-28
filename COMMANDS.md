# Commands

This will contains some useful `ffmpeg` commands.

### Convert to WAV:

```cmd
ffmpeg -i input.mp3 -c:a pcm_s16le -ac 2 output.wav
```

### Convert to MP3:

**Copy Quality:**

```cmd
ffmpeg -i input.mp4 -c:a libmp3lame -b:a copy -vn output.mp3
```

**With Sampling Rate or Frequency:**
```cmd
ffmpeg -i input.mp4 -c:a libmp3lame -ar 44100 -vn output.mp3
```

**With 128kbps bitrate:**
```cmd
ffmpeg -i input.mp4 -c:a libmp3lame -b:a 128k -ar 44100 -vn output.mp3
```

**Without Metadata:**
```cmd
ffmpeg -i input.mp4 -c:a libmp3lame -b:a 128k -ar 44100 -vn -map_metadata 0 output.mp3
```

**With id3 Tag:**
```cmd
ffmpeg -i input.mp4 -c:a libmp3lame -b:a 128k -ar 44100 -vn -map_metadata 0 -id3v2_version 3 output.mp3
```