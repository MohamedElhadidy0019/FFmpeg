#!/bin/bash
make -j 10
rm output_image.jpg
rm out.mp4
./ffmpeg -v verbose \
-hwaccel cuda -hwaccel_output_format cuda -i $1.mp4  \
-init_hw_device cuda \
-filter_complex \
" \
[0:v]scale_cuda=format=nv12[output_wanted];
[output_wanted]bilateral_cuda=window_size=9:sigmaS=3.0:sigmaR=50.0" \
-an -sn -c:v h264_nvenc -cq 20 out.mp4
ffmpeg -i out.mp4 -vf "select=eq(n\,0)" -q:v 3 output_image.jpg
mpv out.mp4

#scale_cuda=format=yuv420p,dummy_cuda