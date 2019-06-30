div=1
width=381
height=256
BlankClip(length=3, width=384, height=512, pixel_type="RGB24", color=$808080)
clip_blank = KillAudio

ImageSource("clip003-0.png", start=0, end=0, pixel_type="RGB24")
clip0 = ShowBlue
ImageSource("clip003-1.png", start=0, end=0, pixel_type="RGB24")
clip1 = ShowBlue
ImageSource("clip003-2.png", start=0, end=0, pixel_type="RGB24")
clip2 = ShowBlue
clip_y = clip0 + clip1 + clip2

clip1 = MergeRGB(clip_y, clip_y, clip_y)
clip2 = MergeRGB(clip_y, clip_blank, clip_blank)
clip3 = MergeRGB(clip_blank, clip_blank, clip_y)
clip1 + clip2 + clip3

Crop(0, 0, width, height)

global heightstep = 1
Import("MakeBands.avsi")
