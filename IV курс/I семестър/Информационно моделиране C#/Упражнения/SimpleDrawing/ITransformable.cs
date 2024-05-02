using System;
using System.Drawing;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleDrawing
{
    public interface ITransformable
    {
        void Translate(int dX, int dY, int item);
        int Contains(int X, int Y);
        Rectangle GetBounds();
    }
}
