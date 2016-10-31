clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$29a5af)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$91a5af)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$515b51)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$7e5b51)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio

ConvertToYV12(chromaresample="point")
