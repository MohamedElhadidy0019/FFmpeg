make -j 10
./ffmpeg -v verbose \
-hwaccel cuda -hwaccel_output_format cuda -i input_green.mp4  \
-hwaccel cuda -hwaccel_output_format cuda -i base_video.mp4 \
-init_hw_device cuda \
-filter_complex \
" \
[0:v]chromakey_cuda=0x25302D:0.1:0.12:1[overlay_video];
[1:v]scale_cuda=format=yuv420p[base];
[base][overlay_video]overlay_cuda" \
-an -sn -c:v h264_nvenc -cq 20 output.mp4

mpv overlay_test.mp4
rm overlay_test.mp4
#scale_cuda=format=yuv420p,dummy_cuda