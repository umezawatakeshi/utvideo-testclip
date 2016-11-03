clip_1 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$fffff5ff)
clip_2 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ff8273d3)
clip_3 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ff6a631d)
clip_4 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ff453e00)

WeaveColumns(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
