progint="progressive"
pred="median"
div=11
width=322
height=256
prop=progint + "-" + pred + "-" + String(width) + "x" + String(height)

BlankClip(length=1, width=width, height=height, pixel_type="RGB24", color=$808080)
clip_blank = KillAudio

ImageSource("clip002-1x1-" + prop + ".png", start=0, end=0, pixel_type="RGB24")
clip_grad = ShowBlue

clip1 = MergeRGB(clip_grad, clip_grad, clip_grad)
clip2 = MergeRGB(clip_grad, clip_blank, clip_blank)
clip3 = MergeRGB(clip_blank, clip_blank, clip_grad)
clip1 + clip2 + clip3

global heightstep = (progint == "progressive") ? 1 : 2
Import("MakeBands.avsi")
