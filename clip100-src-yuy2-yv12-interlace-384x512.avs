clip_1 = BlankClip(length=1, width=384, height=256, pixel_type="YV12", color_yuv=$807060)
clip_2 = BlankClip(length=1, width=384, height=256, pixel_type="YV12", color_yuv=$80a090)

WeaveRows(clip_1 + clip_2, 2)

KillAudio
