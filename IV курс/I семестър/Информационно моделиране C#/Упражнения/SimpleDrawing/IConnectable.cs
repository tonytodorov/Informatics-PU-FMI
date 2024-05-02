using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleDrawing
{
    public interface IConnectable
    {
        void Connect(IConnectable target);
        List<ITransformable> Refferences
        {
            get;
            set;
        }
    }
}
