BlankClip(length=1, width=384, height=256, pixel_type="RGB32", color=$80808080)
clip_blank = KillAudio

ImageSource("clip001.png", start=0, end=0, pixel_type="RGB32")
clip_random = ShowBlue

clip1 = MergeARGB(clip_blank, clip_random, clip_random, clip_random)
clip2 = MergeARGB(clip_blank, clip_random, clip_blank, clip_blank)
clip3 = MergeARGB(clip_blank, clip_blank, clip_blank, clip_random)
clip4 = MergeARGB(clip_random, clip_blank, clip_blank, clip_blank)
clip1 + clip2 + clip3 + clip4
