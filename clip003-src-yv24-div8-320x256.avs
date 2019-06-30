div=8
width=320
height=256
BlankClip(length=3, width=384, height=512, pixel_type="YV24", color_yuv=$808080)
clip_blank = KillAudio

ImageSource("clip003-0.png", start=0, end=0, pixel_type="RGB24")
clip0 = ShowBlue.ConvertToYV24(matrix="PC.601")
ImageSource("clip003-1.png", start=0, end=0, pixel_type="RGB24")
clip1 = ShowBlue.ConvertToYV24(matrix="PC.601")
ImageSource("clip003-2.png", start=0, end=0, pixel_type="RGB24")
clip2 = ShowBlue.ConvertToYV24(matrix="PC.601")
clip_y = clip0 + clip1 + clip2

clip1 = YToUV(clip_blank, clip_blank, clip_y)
clip2 = YToUV(clip_y, clip_blank, clip_blank)
clip3 = YToUV(clip_blank, clip_y, clip_blank)
clip1 + clip2 + clip3

ConvertToYV24(chromaresample="point")
Crop(0, 0, width, height)

global heightstep = 1
Import("MakeBands.avsi")
