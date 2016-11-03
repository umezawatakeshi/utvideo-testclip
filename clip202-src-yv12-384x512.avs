clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$f0a880)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$80a880)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$606088)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$406088)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio

ConvertToYV12(chromaresample="point")
