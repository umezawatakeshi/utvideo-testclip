clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$fffffcff)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff827ad7)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff6b601a)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff463a00)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
