using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace SimpleDrawing
{
    [Serializable()]
    public class Coefficient : IDrawable, ITransformable, IConnectable, IEditable, IRenderable
    {
    	#region Members

        private string _name;
        private string _formula;

        private Rectangle _rect;
        private List<ITransformable> _refferences;
        private static int Count;

        public Brush _border;

        #endregion
        
        #region Properties

        public string Name
        {
            get { return _name; }
        }

        public String Formula
        {
            get { return _formula; }
        }

        public Brush Border
        {
            set { _border = value; }
            get { return _border; }
        }
        #endregion

        #region Constructors

        public Coefficient(Rectangle rect)
        {
            _name = "Coefficient" + (++Count);
            _rect = rect;
            _refferences = new List<ITransformable>();
        }

        #endregion

        #region IDrawable

        public void Draw(object sender, Graphics g, params Brush[] colour)
        {
            g.FillEllipse(Brushes.LightSalmon, _rect);
            Pen pen = (Border != null) ? new Pen(Border) : new Pen(Color.Bisque);
            pen.Width = 4;

            g.DrawEllipse(pen, _rect);
            if (this.Name != null)
            {
                StringFormat tf = new StringFormat();
                tf.LineAlignment = StringAlignment.Far;
                tf.Alignment = StringAlignment.Center;

                using (Font tFont = new Font("Tahoma", 10))
                {
                    g.DrawString(_name, tFont, Brushes.Black, _rect.X + _rect.Width / 2, _rect.Y, tf);
                }
            }
        }

        #endregion
        
        #region ITransformable
        
        public void Translate(int dX, int dY, int item)
        {
        	if (item == 0)
        	{
	            int newX = dX + _rect.X;
	            int newY = dY + _rect.Y;
	            _rect = new Rectangle(newX, newY, _rect.Width, _rect.Height);
        	}
        }

        public int Contains(int X, int Y)
        {
        	return _rect.Contains(X, Y) ? 0 : -1;
        }

        public Rectangle GetBounds()
        {
            return this._rect;
        }

        #endregion
        
        #region IConnectable
        
        public void Connect(IConnectable target)
        {
            this._refferences.Add((ITransformable)target);
        }

        public List<ITransformable> Refferences
        {
            get { return _refferences; }
            set { _refferences = value; }
        }

        #endregion

        #region IEditable

        public object this[String key]
        {
            get
            {
                if (key == "NAME")
                    return _name;
                else if (key == "FORMULA")
                    return _formula;
                else
                    return null;
            }

            set
            {
                if (key == "NAME")
                    _name = Convert.ToString(value);
                else if (key == "FORMULA")
                    _formula = Convert.ToString(value);
            }
        }

        public List<PropertyDescriptor> GetEditableProperties()
        {
            List<PropertyDescriptor> editableProperties = new List<PropertyDescriptor>();

            editableProperties.Add(new PropertyDescriptor("Name:", "NAME", typeof(String)));
            editableProperties.Add(new PropertyDescriptor("Formula:", "FORMULA", typeof(String)));

            return editableProperties;
        }

        #endregion

        #region IRenderable

        public string Render()
        {
            return _name;
        }

        public string GetVariables()
        {
            string result;
            result = _name + "=" + this._formula.ToString() + Environment.NewLine;
            return result;
        }

        public string GetHint()
        {
            return this._name + " : " + this._formula;
        }

        #endregion
    }
}
