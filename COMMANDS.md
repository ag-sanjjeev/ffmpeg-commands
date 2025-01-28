# Commands

This will contains some useful `ffmpeg` commands.

### Show File Information:

**Show Bit rate of file:**
```cmd
ffprobe -i filename.mp4 -v quiet -show_entries stream=bit_rate -hide_banner
```

### Limit Number Of Resource:

Use `-threads` flag followed by number threads to be allocated. Leave if does not know about threads about your device CPU. This will affect overall performance of the device. Consider, to use lower numbers. For faster conversion, use near or below to the maximum number of threads available in your device CPU.

```cmd
ffmpeg -i video.mp4 -b:a 192K -vn -threads 1 music.mp3
```

### Multiple Audio Track Conversion:

**Add Multiple Audio Tracks to Existing Video:**
The below example takes `video.mp4` video file, `audio1.mp3` and `audio2.mp3` audio files. Here, language identification used as `Tamil`.  

```cmd
ffmpeg -i video.mp4 -i audio1.mp3 -i audio2.mp3 -map 1 -metadata:s:a:0 language=tam title="Original Audio" -map 2 -metadata:s:a:1 language=tam title="Filtered Audio" -codec copy -threads 1 video1.mp4
```

### Multiple Video Into Single Video:

Use `concat` with input files.

```cmd
ffmpeg -i "concat:VTS_01_1.VOB|VTS_01_2.VOB" -vcodec libx264 -acodec aac output.mp4
```

### Video Upscaling:

This will upscale video resolution by twice the actual width and height.
default `flags` is `bicubic`, but `lanczos` popular.

```cmd
ffmpeg -i filename.mp4 -vf scale=iw*2:ih*2:flags=lanczos -threads 1 output.mp4 
```

For fixed width and auto height. use `scale=1280:-1` 
```cmd
ffmpeg -i filename.mp4 -vf scale=1280:-1:flags=lanczos -threads 1 output.mp4 
```

**Video upscaling with multiple audio track and combined multiple video:**
```cmd
ffmpeg -i "concat:VTS_01_1.VOB|VTS_01_2.VOB" -i audio1.mp3 -i audio2.mp3 
	  -map 0:v:0 -vf scale=iw*2:ih*2:flags=lanczos 
	  -map 1:a:0 -metadata:s:a:0 title="Audio 1"
	  -map 2:a:0 -metadata:s:a:1 title="Audio 2"
	  -threads 1 
	  output-combined-scaled-multi-track.mp4
```

### Convert Entire Directory Files:

**From WEBM files to MP4:**
```cmd
for %i in (*.webm) do ffmpeg -i "%i" -vcodec libx264 -acodec aac -threads 1 "%~ni.mp4"
```

### Convert From URL:

**Directly Convert Instead of Download:**
```cmd
ffmpeg -i "REMOTE URL TO CONVERT FILE" -c:v libx264 -preset slow -crf 22 "saveas.mp4"
```

*Example:*
```cmd
ffmpeg -i "http://host/folder/file.m3u8" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 file.mp4
```

### Loseless Conversion Logic:

1. Make a lossless RGB output first:
```cmd
ffmpeg -y -framerate 25 -video_size 1280x1024 -f x11grab -i :0.0 -c:v libx264rgb -crf 0 -preset ultrafast temp.mp4
```
- The input is RGB, so using the encoder `libx264rgb` will avoid the potentially slow `RGB` to `YUV` conversion that would occur if you use plain `libx264`.
- This uses the quickest `x264` encoding with preset: `ultrafast`.
- The output will be lossless because `-crf 0` flag is used.

2. Then re-encode it:
- The output from the first command will be huge, and most dumb players can't handle `RGB H.264`. So you can re-encode it with following command:

```cmd
ffmpeg -i temp.mp4 -c:v libx264 -crf 23 -preset medium -vf format=yuv420p out.mp4
```

- You can experiment with the `-crf` value to control output quality. A subjectively sane range is 18-28, where 18 is visually lossless or nearly so. Default is 23.
- Use the slowest preset, if you have patience for. The presets are 
	- ultrafast, 
	- superfast, 
	- veryfast, 
	- faster, 
	- fast, 
	- medium, (Default)
	- slow, 
	- slower, 
	- veryslow. 
- Here, `-vf format=yuv420p` to ensure the output works with dumb players like classic old media players or system with lower resources. You can omit this flags, if you're uploading it to Online Streaming platform or only playing it on FFmpeg based players.

### Convert to AAC:

**From MP4 to AAC:**
```cmd
ffmpeg -i filename.mp4 -vn -acodec copy filename.aac
```

### Convert to WAV:

```cmd
ffmpeg -i input.mp3 -c:a pcm_s16le -ac 2 output.wav
```

### Convert to MP3:

**From MP4 to MP3 without Codec:**
```cmd
ffmpeg -i video.mp4 -b:a 192K -vn music.mp3
```

**From MP4 to MP3 with Loseless Quality:**
```cmd
ffmpeg -i in.mp4 -q:a 0 -map a out.mp3
```

```cmd
ffmpeg -i video.mp4 -vn audio.mp3
```

**From MP4 to MP3:**
```cmd
ffmpeg -i filename.mp4 -vn -codec:a libmp3lame -b:a 192K filename.mp3
```

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

### Convert to VOB:

**From MP4 to VOB:**
```cmd
ffmpeg -i filename.mp4 -target ntsc-dvd filename.vob
```

### Convert to MP4:

**From WEBM to MP4:**
```cmd
ffmpeg -i filename.webm -vcodec libx264 -acodec aac filename.mp4
```

**From FLV to MP4:**
```cmd
ffmpeg -i input.flv -vcodec libx264 -acodec aac output.mp4
```

**From MP4 to MP4:**
```cmd
ffmpeg -i video_1080p.mp4 -c:v libx264 -b:v 3M -bufsize 6M -maxrate 4.5M -threads 1 -g 120 -tune psnr -report video_1080p_3M.mp4
```