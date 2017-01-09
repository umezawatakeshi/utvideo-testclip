clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="YUY2", color_yuv=$807060)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="YUY2", color_yuv=$80a090)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="YUY2", color_yuv=$807060)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="YUY2", color_yuv=$80a090)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
