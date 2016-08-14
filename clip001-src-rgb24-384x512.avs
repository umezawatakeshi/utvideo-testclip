BlankClip(length=1, width=384, height=512, pixel_type="RGB24", color=$808080)
clip_blank = KillAudio

ImageSource("clip001.png", start=0, end=0, pixel_type="RGB24")
clip_random = ShowBlue

clip1 = MergeRGB(clip_random, clip_random, clip_random)
clip2 = MergeRGB(clip_random, clip_blank, clip_blank)
clip3 = MergeRGB(clip_blank, clip_blank, clip_random)
clip1 + clip2 + clip3
