clip_blank_msb = BlankClip(length=1, width=384, height=512, pixel_type="Y8", color_yuv=$800000)
clip_blank_lsb = BlankClip(length=1, width=384, height=512, pixel_type="Y8", color_yuv=$000000)
StackVertical(clip_blank_msb, clip_blank_lsb)
ConvertFromStacked
clip_blank = KillAudio

ImageSource("clip001-10l.png", start=0, end=0, pixel_type="RGB24")
ShowBlue(pixel_type="Y8")
clip_random = ConvertFromStacked

clip1 = CombinePlanes(clip_random, clip_blank, clip_blank, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
clip2 = CombinePlanes(clip_blank, clip_random, clip_blank, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
clip3 = CombinePlanes(clip_blank, clip_blank, clip_random, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
clip1 + clip2 + clip3

ConvertToYUV420(chromaresample="point")
