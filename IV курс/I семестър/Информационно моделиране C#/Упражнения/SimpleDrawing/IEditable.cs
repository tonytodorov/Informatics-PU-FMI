using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleDrawing
{
    public interface IEditable
    {
        Object this[String key]
        {
            get;
            set;
        }

        List<PropertyDescriptor> GetEditableProperties();
    }
}
