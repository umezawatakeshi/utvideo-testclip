function MakeSlice(clip clip, int div, int pos) {
	totalstripes = Int(clip.height / heightstep)
	curstripes = Int(totalstripes * (pos + 1) / div) - \
	             Int(totalstripes * pos / div)
	curheight = curstripes * heightstep
	return CropBottom(clip, clip.height - curheight)
}

function MakeBands(clip clip, int div, int pos) {
	pos = Default(pos, 0)
	curslice = MakeSlice(clip, div, pos)
	return (pos + 1 == div) ? curslice : StackVertical(curslice, MakeBands(clip, div, pos + 1))
}

MakeBands(Last, div, 0)
