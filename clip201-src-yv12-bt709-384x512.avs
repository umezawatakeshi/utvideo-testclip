clip_1 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$208d48)
clip_2 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$ad8d48)
clip_3 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$3f73b8)
clip_4 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$7e73b8)

WeaveColumns(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio

ConvertToYV12(chromaresample="point")
