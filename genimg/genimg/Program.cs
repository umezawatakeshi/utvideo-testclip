using System;
using System.Drawing;

class Program
{
    //static string basepath = "D:\\proj\\utvideo\\testclip";
    static string basepath = "..\\..\\..\\..";

    static void Main(string[] args)
    {
        Random r = new Random(0);

        {
            Bitmap bm = new Bitmap(384, 512);
            for (var y = 0; y < bm.Height; y++)
                for (var x = 0; x < bm.Width; x++)
                    bm.SetPixel(x, y, Color.FromArgb(r.Next(256) * 0x01010101));
            bm.Save(basepath + "\\clip001.png");
        }

        String[] types = { "1x1", "2x1", "2x2" };
        Size[] sizes = { new Size(384, 256), new Size(383, 256), new Size(382, 256), new Size(381, 256), new Size(320, 256), new Size(318, 256), new Size(384, 255), new Size(384, 254), new Size(384, 253), new Size(384, 512), };
        String[] progints = { "progressive", "interlace" };
        foreach (var type in types)
        {
            int widthstep = type.StartsWith("1x") ? 1 : 2;
            int heightstep = type.Contains("x2") ? 2 : 1;
            foreach (var size in sizes)
            {
                foreach (var progint in progints)
                {
                    int heightunit = heightstep * ((progint == "progressive") ? 1 : 2);

                    if (size.Width % widthstep != 0)
                        continue;
                    if (size.Height % heightunit != 0)
                        continue;

                    Bitmap bml = new Bitmap(size.Width, size.Height);
                    Byte v = 0x80;
                    for (var y = 0; y < size.Height; y += heightstep)
                    {
                        for (var x = 0; x < size.Width; x += widthstep)
                        {
                            v += 3;
                            for (var xx = 0; xx < widthstep; xx++)
                                for (var yy = 0; yy < heightstep; yy++)
                                    bml.SetPixel(x + xx, y + yy, Color.FromArgb(v * 0x01010101));
                        }
                    }
                    bml.Save(basepath + "\\clip002-" + type + "-" + progint + "-left-" + size.Width + "x" + size.Height + ".png");

                    Bitmap bmg = new Bitmap(size.Width, size.Height);
                    v = 0x80;
                    for (var y = 0; y < heightunit; y += heightstep)
                    {
                        for (var x = 0; x < size.Width; x += widthstep)
                        {
                            v += 3;
                            for (var xx = 0; xx < widthstep; xx++)
                                for (var yy = 0; yy < heightstep; yy++)
                                    bmg.SetPixel(x + xx, y + yy, Color.FromArgb(v * 0x01010101));
                        }
                    }
                    for (var y = heightunit; y < size.Height; y += heightstep)
                    {
                        for (var x = 0; x < size.Width; x += widthstep)
                        {
                            if (x == 0 && y % heightunit == 0)
                            {
                                v = bmg.GetPixel(x, y - heightunit).B;
                            }
                            else
                            {
                                byte left = (x > 0) ? bmg.GetPixel(x - 1, y).B : bmg.GetPixel(size.Width - 1, y - heightstep).B;
                                byte top = bmg.GetPixel(x, y - heightunit).B;
                                byte topleft = (x > 0) ? bmg.GetPixel(x - 1, y - heightunit).B : bmg.GetPixel(size.Width - 1, y - heightunit - heightstep).B;
                                v = (byte)(left + top - topleft);
                            }
                            v += (byte)3;
                            for (var xx = 0; xx < widthstep; xx++)
                                for (var yy = 0; yy < heightstep; yy++)
                                    bmg.SetPixel(x + xx, y + yy, Color.FromArgb(v * 0x01010101));
                        }
                    }
                    bmg.Save(basepath + "\\clip002-" + type + "-" + progint + "-gradient-" + size.Width + "x" + size.Height + ".png");

                    Bitmap bmm = new Bitmap(size.Width, size.Height);
                    v = 0x80;
                    for (var y = 0; y < heightunit; y += heightstep)
                    {
                        for (var x = 0; x < size.Width; x += widthstep)
                        {
                            v += 3;
                            for (var xx = 0; xx < widthstep; xx++)
                                for (var yy = 0; yy < heightstep; yy++)
                                    bmm.SetPixel(x + xx, y + yy, Color.FromArgb(v * 0x01010101));
                        }
                    }
                    for (var y = heightunit; y < size.Height; y += heightstep)
                    {
                        for (var x = 0; x < size.Width; x += widthstep)
                        {
                            if (x == 0 && y < heightunit * 2)
                            {
                                v = bmm.GetPixel(x, y - heightunit).B;
                            }
                            else
                            {
                                byte left = (x > 0) ? bmm.GetPixel(x - 1, y).B : bmm.GetPixel(size.Width - 1, y - heightstep).B;
                                byte top = bmm.GetPixel(x, y - heightunit).B;
                                byte topleft = (x > 0) ? bmm.GetPixel(x - 1, y - heightunit).B : bmm.GetPixel(size.Width - 1, y - heightunit - heightstep).B;
                                byte grad = (byte)(left + top - topleft);
                                v = Math.Min(Math.Max(Math.Min(left, top), grad), Math.Max(left, top));
                            }
                            v += (byte)3;
                            for (var xx = 0; xx < widthstep; xx++)
                                for (var yy = 0; yy < heightstep; yy++)
                                    bmm.SetPixel(x + xx, y + yy, Color.FromArgb(v * 0x01010101));
                        }
                    }
                    bmm.Save(basepath + "\\clip002-" + type + "-" + progint + "-median-" + size.Width + "x" + size.Height + ".png");
                }
            }
        }
    }
}
