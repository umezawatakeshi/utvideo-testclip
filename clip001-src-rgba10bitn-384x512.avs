clip_blank_msb = BlankClip(length=1, width=384, height=512, pixel_type="Y8", color_yuv=$800000)
clip_blank_lsb = BlankClip(length=1, width=384, height=512, pixel_type="Y8", color_yuv=$200000)
StackVertical(clip_blank_msb, clip_blank_lsb)
ConvertFromStacked
clip_blank = KillAudio

ImageSource("clip001-10fn.png", start=0, end=0, pixel_type="RGB24")
ShowBlue(pixel_type="Y8")
clip_random = ConvertFromStacked

clip1 = CombinePlanes(clip_random, clip_random, clip_random, clip_blank, planes="RGBA", source_planes="YYYY", pixel_type="RGBAP16")
clip2 = CombinePlanes(clip_random, clip_blank, clip_blank, clip_blank, planes="RGBA", source_planes="YYYY", pixel_type="RGBAP16")
clip3 = CombinePlanes(clip_blank, clip_blank, clip_random, clip_blank, planes="RGBA", source_planes="YYYY", pixel_type="RGBAP16")
clip4 = CombinePlanes(clip_blank, clip_blank, clip_blank, clip_random, planes="RGBA", source_planes="YYYY", pixel_type="RGBAP16")
clip1 + clip2 + clip3 + clip4
ConvertToRGB64
