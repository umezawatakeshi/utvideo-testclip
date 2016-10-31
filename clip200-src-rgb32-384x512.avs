clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff0000ff)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff00ff00)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ffff0000)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff808080)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
