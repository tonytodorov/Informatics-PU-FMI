using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;

namespace SimpleDrawing
{
    [Serializable()]
    public class Stock : IDrawable, ITransformable, IConnectable, IEditable, IRenderable
    {
    	#region Members
    	
    	private Rectangle _rect;
    	
        private string _name;
        private decimal _initialValue;

        public Flow _inFlow, _outFlow;

        public Brush _color;
        
        private List<ITransformable> _refferences;
        
        #endregion

        #region Properties

        public Flow InFlow
        {
            get { return _inFlow; }
            set { _inFlow = value; }
        }

        public Flow OutFlow
        {
            get { return _outFlow; }
            set { _outFlow = value; }
        }

        public String Name
        {
            get { return _name; }
        }

        public Brush color
        {
            get { return _color; }
            set { _color = value; }
        }

        public Rectangle Rectangle
        {
            get { return _rect; }
            set { _rect = value; }
        }

        public List<ITransformable> Refferences
        {
            get { return _refferences; }
            set { _refferences = value; }
        }

        #endregion
        
        #region Constructors
        
        public Stock(Rectangle rect)
        {
            _rect = rect;
            _refferences = new List<ITransformable>();
        }

        public Stock(Rectangle rect, Brush color) : this (rect)
        {
            _color = color;
           
        }
        
        #endregion

        #region IDrawable
        
        public void Draw(object sender, Graphics g, params Brush[] colour)
        {
            using (Pen pen = new Pen(Color.Black, 2))
            {
                Point start = new Point(this._rect.X + this._rect.Width / 2, this._rect.Y + this._rect.Height / 2);
                foreach (ITransformable item in this._refferences)
                {
                    Rectangle target = item.GetBounds();
                    g.DrawLine(pen, start, new Point(target.X + target.Width / 2, target.Y + target.Height / 2));
                }
               
                
                g.FillRectangle((color != null) ? color : Brushes.Green, _rect);
                g.DrawRectangle(pen, _rect);
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
		
        #endregion

        #region IEditable

        public object this[String key]
        {
            get
            {
                if (key == "NAME")
                    return _name;
                else if (key == "INITIAL_VALUE")
                    return _initialValue;
                else
                    return null;
            }

            set
            {
                if (key == "NAME")
                    _name = Convert.ToString(value);
                else if (key == "INITIAL_VALUE")
                    _initialValue = Convert.ToDecimal(value);
            }
        }

        public List<PropertyDescriptor> GetEditableProperties()
        {
            List<PropertyDescriptor> editableProperties = new List<PropertyDescriptor>();

            editableProperties.Add(new PropertyDescriptor("Name:", "NAME", typeof(String)));
            editableProperties.Add(new PropertyDescriptor("Initial Value:", "INITIAL_VALUE", typeof(Decimal)));

            return editableProperties;
        }

        #endregion

        #region IRenderable

        public string Render()
        {
            string result = "";
            
            if (_inFlow == null || _outFlow == null) return result;

            result = GetVariables();
            result += _name + "'=" + "(" + _inFlow.Render() + ")" + "-(" + _outFlow.Render() + ")";

            return result;
        }

        public string GetVariables()
        {
            string result = "";
            result += _name + "=" + _initialValue.ToString() + Environment.NewLine;
            result += _inFlow.GetVariables() + _outFlow.GetVariables();
            return result;
        }

        public string GetHint()
        {
            return _name + " : " + _initialValue;
        }

        #endregion
    }
}