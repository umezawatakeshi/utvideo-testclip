pred="left"
div=1
width=384
height=256
prop=pred + "-" + String(width) + "x" + String(height)

clip_blank_msb = BlankClip(length=1, width=width, height=height, pixel_type="Y8", color_yuv=$800000)
clip_blank_lsb = BlankClip(length=1, width=width, height=height, pixel_type="Y8", color_yuv=$000000)
StackVertical(clip_blank_msb, clip_blank_lsb)
ConvertFromStacked
clip_blank = KillAudio

ImageSource("clip002-10l-1x1-" + prop + ".png", start=0, end=0, pixel_type="RGB24")
ShowBlue(pixel_type="Y8")
clip_y = ConvertFromStacked

ImageSource("clip002-10l-2x2-" + prop + ".png", start=0, end=0, pixel_type="RGB24")
ShowBlue(pixel_type="Y8")
clip_c = ConvertFromStacked

clip1 = CombinePlanes(clip_y, clip_blank, clip_blank, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
clip2 = CombinePlanes(clip_blank, clip_c, clip_blank, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
clip3 = CombinePlanes(clip_blank, clip_blank, clip_c, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
clip1 + clip2 + clip3

ConvertToYUV420(chromaresample="point")

global heightstep = 2
Import("MakeBands.avsi")
