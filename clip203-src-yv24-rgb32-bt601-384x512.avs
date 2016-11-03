clip_1 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ffffffff)
clip_2 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ff8263ff)
clip_3 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ffdd1c5d)
clip_4 = BlankClip(length=1, width=96, height=512, pixel_type="RGB32", color=$ff008500)

WeaveColumns(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
