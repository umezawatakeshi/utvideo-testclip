clip_msb = BlankClip(length=1, width=384, height=256, pixel_type="Y8", color_yuv=$800000)
clip_lsb = BlankClip(length=1, width=384, height=256, pixel_type="Y8", color_yuv=$200000)
StackVertical(clip_msb, clip_lsb)
clip = ConvertFromStacked
CombinePlanes(clip, planes="RGBA", source_planes="YYYY", pixel_type="RGBAP16")
ConvertToRGB64
KillAudio
