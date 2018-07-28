progint="interlace"
pred="gradient"
div=8
width=384
height=256
prop=progint + "-" + pred + "-" + String(width) + "x" + String(height)

BlankClip(length=1, width=width, height=height, pixel_type="RGB32", color=$80808080)
clip_blank = KillAudio

ImageSource("clip002-1x1-" + prop + ".png", start=0, end=0, pixel_type="RGB32")
clip_grad = ShowBlue

clip1 = MergeARGB(clip_blank, clip_grad, clip_grad, clip_grad)
clip2 = MergeARGB(clip_blank, clip_grad, clip_blank, clip_blank)
clip3 = MergeARGB(clip_blank, clip_blank, clip_blank, clip_grad)
clip4 = MergeARGB(clip_grad, clip_blank, clip_blank, clip_blank)
clip1 + clip2 + clip3 + clip4

global heightstep = (progint == "progressive") ? 1 : 2
Import("MakeBands.avsi")
