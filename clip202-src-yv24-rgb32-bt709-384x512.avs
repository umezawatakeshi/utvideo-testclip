clip_1 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ffffffff)
clip_2 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff8271ff)
clip_3 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ffed335d)
clip_4 = BlankClip(length=1, width=384, height=128, pixel_type="RGB32", color=$ff006800)

WeaveRows(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
