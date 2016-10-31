clip_1 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$29f06e)
clip_2 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$913622)
clip_3 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$515af0)
clip_4 = BlankClip(length=1, width=96, height=512, pixel_type="YV24", color_yuv=$7e8080)

WeaveColumns(clip_1 + clip_2 + clip_3 + clip_4, 4)

KillAudio
