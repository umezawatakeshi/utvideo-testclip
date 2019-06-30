div=1
width=318
height=256
BlankClip(length=3, width=384, height=512, pixel_type="RGB32", color=$FF808080)
clip_blank = KillAudio

ImageSource("clip003-0.png", start=0, end=0, pixel_type="RGB32")
clip0 = ShowBlue
ImageSource("clip003-1.png", start=0, end=0, pixel_type="RGB32")
clip1 = ShowBlue
ImageSource("clip003-2.png", start=0, end=0, pixel_type="RGB32")
clip2 = ShowBlue
clip_y = clip0 + clip1 + clip2

clip1 = MergeARGB(clip_blank, clip_y, clip_y, clip_y)
clip2 = MergeARGB(clip_blank, clip_y, clip_blank, clip_blank)
clip3 = MergeARGB(clip_blank, clip_blank, clip_blank, clip_y)
clip1 + clip2 + clip3

Crop(0, 0, width, height)

global heightstep = 1
Import("MakeBands.avsi")
