clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$f08080)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$80d080)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$6080d0)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="YV24", color_yuv=$404040)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio

ConvertToYUY2(chromaresample="point")
