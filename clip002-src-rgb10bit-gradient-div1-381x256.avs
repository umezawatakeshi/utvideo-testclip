pred="gradient"
div=1
width=381
height=256
prop=pred + "-" + String(width) + "x" + String(height)

clip_blank_msb = BlankClip(length=1, width=width, height=height, pixel_type="Y8", color_yuv=$800000)
clip_blank_lsb = BlankClip(length=1, width=width, height=height, pixel_type="Y8", color_yuv=$200000)
StackVertical(clip_blank_msb, clip_blank_lsb)
ConvertFromStacked
clip_blank = KillAudio

ImageSource("clip002-10f-1x1-" + prop + ".png", start=0, end=0, pixel_type="RGB32")
ShowBlue(pixel_type="Y8")
clip_grad = ConvertFromStacked

clip1 = CombinePlanes(clip_grad, clip_grad, clip_grad, planes="RGB", source_planes="YYY", pixel_type="RGBP16")
clip2 = CombinePlanes(clip_grad, clip_blank, clip_blank, planes="RGB", source_planes="YYY", pixel_type="RGBP16")
clip3 = CombinePlanes(clip_blank, clip_blank, clip_grad, planes="RGB", source_planes="YYY", pixel_type="RGBP16")
clip1 + clip2 + clip3
ConvertToRGB64

global heightstep = 1
Import("MakeBands.avsi")
