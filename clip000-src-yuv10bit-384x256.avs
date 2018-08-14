clip_msb = BlankClip(length=1, width=384, height=256, pixel_type="Y8", color_yuv=$800000)
clip_lsb = BlankClip(length=1, width=384, height=256, pixel_type="Y8", color_yuv=$000000)
StackVertical(clip_msb, clip_lsb)
clip = ConvertFromStacked
CombinePlanes(clip, planes="YUV", source_planes="YYY", pixel_type="YUV444P16")
KillAudio
