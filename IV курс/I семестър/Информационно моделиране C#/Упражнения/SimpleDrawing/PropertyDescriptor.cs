using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleDrawing
{
    public class PropertyDescriptor
    {
        private string _caption;
        private string _key;
        private Type _type;

        public String Caption
        {
            get { return _caption; }
        }
        public String Key
        {
            get { return _key; }
        }
        public Type Type
        {
            get { return _type; }
        }

        public PropertyDescriptor(string caption, string key, Type type)
        {
            _caption = caption;
            _key = key;
            _type = type;
        }
    }
}
