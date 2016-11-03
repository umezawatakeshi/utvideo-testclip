clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$fffff5ff)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff8f8842)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff5d4dae)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff453e00)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
