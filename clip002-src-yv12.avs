prop=progint + "-" + pred + "-" + div + "-" + String(width) + "x" + String(height)

BlankClip(length=1, width=width, height=height, pixel_type="YV24", color_yuv=$808080)
clip_blank = KillAudio

ImageSource("clip002-1x1h2-" + prop + ".png", start=0, end=0, pixel_type="RGB24")
clip_y = ShowBlue.ConvertToYV24(matrix="PC.601")

ImageSource("clip002-2x2h2-" + prop + ".png", start=0, end=0, pixel_type="RGB24")
clip_c = ShowBlue.ConvertToYV24(matrix="PC.601")

clip1 = YToUV(clip_blank, clip_blank, clip_y)
clip2 = YToUV(clip_c, clip_blank, clip_blank)
clip3 = YToUV(clip_blank, clip_c, clip_blank)
clip1 + clip2 + clip3

ConvertToYV12(chromaresample="point")
