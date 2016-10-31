clip_1 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$20f076)
clip_2 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$ad2a1a)
clip_3 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$3f66f0)
clip_4 = BlankClip(length=1, width=384, height=256, pixel_type="YV24", color_yuv=$7e8080)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
