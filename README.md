Japanese version is [here](README-ja.md)

# utvideo-testclip

test clips for Ut Video Codec Suite unit test

- **clip000**: one frame, no colorspace conversion, residual is zero for all color elements
- **clip001**: same frames as number of color elements, no colorspace conversion, random residual for correspponding color elements in each frame
- **clip002**: same frames as number of color elements, no colorspace conversion, residual for correspponding color elements in each frame is three
- **clip003**: for UMxx: 3x frames as number of color elements, no colorspace conversion, random residual suitable for interframe compression
- **clip100**: one frame, test for colorspace conversion between same color system with different subsampling
- **clip200**: one frame, test for colorspace conversion from RGB to YUV by horizontal stripe image
- **clip201**: one frame, test for colorspace conversion from RGB to YUV by vertical stripe image
- **clip202**: one frame, test for colorspace conversion from YUV to RGB by horizontal stripe image
- **clip203**: one frame, test for colorspace conversion from YUV to RGB by vertical stripe image
