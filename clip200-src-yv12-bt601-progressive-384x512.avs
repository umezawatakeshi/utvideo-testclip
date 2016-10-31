clip_1 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$299348)
clip_2 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$919348)
clip_3 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$516db8)
clip_4 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$7e6db8)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio

ConvertToYV12(chromaresample="point")
