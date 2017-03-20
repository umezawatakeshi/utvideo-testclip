progint="progressive"
pred="gradient"
div="div8"
width=382
height=256
prop=progint + "-" + pred + "-" + div + "-" + String(width) + "x" + String(height)

BlankClip(length=1, width=width, height=height, pixel_type="RGB32", color=$FF808080)
clip_blank = KillAudio

ImageSource("clip002-1x1h1-" + prop + ".png", start=0, end=0, pixel_type="RGB32")
clip_grad = ShowBlue

clip1 = MergeARGB(clip_blank, clip_grad, clip_grad, clip_grad)
clip2 = MergeARGB(clip_blank, clip_grad, clip_blank, clip_blank)
clip3 = MergeARGB(clip_blank, clip_blank, clip_blank, clip_grad)
clip1 + clip2 + clip3
