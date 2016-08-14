BlankClip(length=1, width=384, height=512, pixel_type="YV24", color_yuv=$808080)
clip_blank = KillAudio

ImageSource("clip001.png", start=0, end=0, pixel_type="RGB32")
clip_random = ShowBlue.ConvertToYV24(matrix="PC.601")

clip1 = YToUV(clip_blank, clip_blank, clip_random)
clip2 = YToUV(clip_random, clip_blank, clip_blank)
clip3 = YToUV(clip_blank, clip_random, clip_blank)
clip1 + clip2 + clip3

ConvertToYUY2(chromaresample="point")
