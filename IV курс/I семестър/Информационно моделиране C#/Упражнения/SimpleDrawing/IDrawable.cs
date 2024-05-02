using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace SimpleDrawing
{
    public interface IDrawable
    {

        void Draw(object sender, Graphics graphics, params Brush[] colour);
    }
}
