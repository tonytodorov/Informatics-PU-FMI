using System;
using System.Collections.Generic;
using System.Drawing;

namespace SimpleDrawing
{
    [Serializable()]
    public class Flow : IDrawable, ITransformable, IConnectable, IEditable, IRenderable
    {
    	#region Members

        private String _name;
        private String _formula;

        public Nullable<Rectangle> _startRect, _endRectangle;
        private Rectangle _middleRectangle;
        
        public Stock _source, _destination;
        
        private List<ITransformable> _refferences;
        
        public const int _rectWidth = 16;
        public const int _rectHeight = 16;

        #endregion
        
        #region Constructors
        
        public Flow(Nullable<Rectangle> startRect, Nullable<Rectangle> endRectangle)
        {
            this._startRect = new Rectangle(startRect.Value.X - _rectWidth/2, startRect.Value.Y - _rectHeight/2, _rectWidth, _rectHeight);
            this._endRectangle = new Rectangle(endRectangle.Value.X - _rectWidth / 2, endRectangle.Value.Y - _rectHeight / 2, _rectWidth, _rectHeight);
            int X = Math.Min(startRect.Value.X, endRectangle.Value.X) + (Math.Max(startRect.Value.X, endRectangle.Value.X) - Math.Min(startRect.Value.X, endRectangle.Value.X))/2;
            int Y = Math.Min(startRect.Value.Y, endRectangle.Value.Y) + (Math.Max(startRect.Value.Y, endRectangle.Value.Y) - Math.Min(startRect.Value.Y, endRectangle.Value.Y))/2;
            this._middleRectangle = new Rectangle(X - _rectWidth / 2, Y - _rectHeight / 2, _rectWidth, _rectHeight);
            
            this._source = null;
            this._destination = null;
            
            _refferences = new List<ITransformable>();
        }
        
        public Flow(Nullable<Rectangle> startRect, Stock destination)
        {
            this._startRect = new Rectangle(startRect.Value.X - _rectWidth/2, startRect.Value.Y - _rectHeight/2, _rectWidth, _rectHeight);
            this._endRectangle = null;
            int X = Math.Min(startRect.Value.X, destination.GetBounds().X) + (Math.Max(startRect.Value.X, destination.GetBounds().X) - Math.Min(startRect.Value.X, destination.GetBounds().X))/2;
            int Y = Math.Min(startRect.Value.Y, destination.GetBounds().Y) + (Math.Max(startRect.Value.Y, destination.GetBounds().Y) - Math.Min(startRect.Value.Y, destination.GetBounds().Y))/2;
            this._middleRectangle = new Rectangle(X - _rectWidth / 2, Y - _rectHeight / 2, _rectWidth, _rectHeight);
            
            this._source = null;
            this._destination = destination;
            
            _refferences = new List<ITransformable>();
        }
        
        public Flow(Stock source, Nullable<Rectangle> endRectangle)
        {
            this._startRect = null;
            Point point = new Point(endRectangle.Value.X + endRectangle.Value.Width / 2, endRectangle.Value.Y + endRectangle.Value.Height / 2);

            this._endRectangle = new Rectangle(endRectangle.Value.X - _rectWidth / 2, endRectangle.Value.Y - _rectHeight / 2, _rectWidth, _rectHeight);

            Point sPoint;
            Rectangle rect = source.GetBounds();
            sPoint = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);

            int X = Math.Abs(sPoint.X + point.X) / 2 - _rectWidth / 2;
            int Y = Math.Abs(sPoint.Y + point.Y) / 2 - _rectHeight / 2;

            this._middleRectangle = new Rectangle(X, Y, _rectWidth, _rectHeight);

            this._source = source;
            this._destination = null;
            
            _refferences = new List<ITransformable>();
        }

        public Flow(Stock source, Stock destination)
        {
            this._startRect = null;
            this._endRectangle = null;

            Rectangle eRect = destination.GetBounds();
            Point point = new Point(eRect.X + eRect.Width / 2, eRect.Y + eRect.Height / 2);
            Point sPoint;
            Rectangle rect = source.GetBounds();

            this._endRectangle = new Rectangle(eRect.X - _rectWidth / 2, eRect.Y - _rectHeight / 2, _rectWidth, _rectHeight);

            sPoint = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);

            int X = (sPoint.X + point.X) / 2 - _rectWidth / 2;
            int Y = (sPoint.Y + point.Y) / 2 - _rectHeight / 2;

            this._middleRectangle = new Rectangle(X, Y, _rectWidth, _rectHeight);


            /*
            Point sPoint = new Point(source.GetBounds().X + source.GetBounds().Width / 2, source.GetBounds().Y + source.GetBounds().Height);
            Point dPoint = new Point(destination.GetBounds().X + destination.GetBounds().Width / 2, destination.GetBounds().Y + destination.GetBounds().Height);

            int X = Math.Min(source.GetBounds().X, destination.GetBounds().X) + (Math.Max(source.GetBounds().X, destination.GetBounds().X) - Math.Min(source.GetBounds().X, destination.GetBounds().X))/2;
            int Y = Math.Min(source.GetBounds().Y, destination.GetBounds().Y) + (Math.Max(source.GetBounds().Y, destination.GetBounds().Y) - Math.Min(source.GetBounds().Y, destination.GetBounds().Y))/2;
            this._middleRectangle = new Rectangle(X - _rectWidth / 2, Y - _rectHeight / 2, _rectWidth, _rectHeight);
            */

            this._source = source;
            this._destination = destination;
            
            _refferences = new List<ITransformable>();
        }
        
        #endregion

        #region Properties

        public String Name
        {
            get{return _name;}
        }

        public String Forumla
        {
            get { return _formula; }
        }

        #endregion
        
        #region IDrawable
        
        public void Draw(object sender, Graphics g, params Brush[] colour)
        {
            Rectangle[] Rects = new Rectangle[6];
            int rCount = 0;

            using (Pen pen = new Pen(Color.Black, 1))
            {
                Point start = new Point(this._middleRectangle.X + this._middleRectangle.Width / 2, this._middleRectangle.Y + this._middleRectangle.Height / 2);

                foreach (ITransformable item in this._refferences)
                {
                    Rectangle target = item.GetBounds();
                    g.DrawLine(pen, start, new Point(target.X + target.Width / 2, target.Y + target.Height / 2));
                }

                if (_startRect != null)
                {
                    Rects[rCount++] = this._startRect.Value;
                    g.DrawRectangle(pen, this._startRect.Value);
                }

                if (this.Name != null)
                {
                    StringFormat tf = new StringFormat();
                    tf.LineAlignment = StringAlignment.Far;
                    tf.Alignment = StringAlignment.Center;

                    using (Font tFont = new Font("Tahoma", 10))
                    {
                        g.DrawString(_name, tFont, Brushes.Black, _middleRectangle.X + _middleRectangle.Width / 2, _middleRectangle.Y, tf);
                    }
                }

                g.DrawRectangle(pen, _middleRectangle);
                Rects[rCount++] = _middleRectangle;

                if (_endRectangle != null)
                {
                    Rects[rCount++] = this._endRectangle.Value;
                    g.DrawRectangle(pen, this._endRectangle.Value);
                }

                Point end;
                if (this._startRect != null)
                {
                    end = new Point(this._startRect.Value.X + this._startRect.Value.Width / 2, this._startRect.Value.Y + this._startRect.Value.Height / 2);
                    Rects[rCount++] = this._startRect.Value;
                }
                else
                    end = new Point(this._source.GetBounds().X + this._source.GetBounds().Width / 2, this._source.GetBounds().Y + this._source.GetBounds().Height / 2);

                g.DrawLine(pen, start, end);

                if (this._endRectangle != null)
                {
                    end = new Point(this._endRectangle.Value.X + this._endRectangle.Value.Width / 2, this._endRectangle.Value.Y + this._endRectangle.Value.Height / 2);
                    Rects[rCount++] = this._endRectangle.Value;
                }
                else
                    end = new Point(this._destination.GetBounds().X + this._destination.GetBounds().Width / 2, this._destination.GetBounds().Y + this._destination.GetBounds().Height / 2);

                g.DrawLine(pen, start, end);

                for (int i = 0; i < rCount; i++)
                {
                    g.FillRectangle(Brushes.Azure, Rects[i]);
                    g.DrawRectangle(pen, Rects[i]);
                }
            }
        }

        #endregion
        
        #region ITransformable
        
        public void Translate(int dX, int dY, int item)
        {
        	if (item == 0)
        	{
	            int newX = dX + _startRect.Value.X;
	            int newY = dY + _startRect.Value.Y;
	            _startRect = new Rectangle(newX, newY, _startRect.Value.Width, _startRect.Value.Height);
        	}
        	else if (item == 1)
        	{
	            int newX = dX + _middleRectangle.X;
	            int newY = dY + _middleRectangle.Y;
                _middleRectangle = new Rectangle(newX, newY, _middleRectangle.Width, _middleRectangle.Height);
        	}
        	else if (item == 2)
        	{
	            int newX = dX + _endRectangle.Value.X;
	            int newY = dY + _endRectangle.Value.Y;
	            _endRectangle = new Rectangle(newX, newY, _endRectangle.Value.Width, _endRectangle.Value.Height);
        	}
        }

        public int Contains(int X, int Y)
        {
        	if ((_startRect != null) && (_startRect.Value.Contains(X, Y)))
        	    return 0;
			else if ((_endRectangle != null) && (_endRectangle.Value.Contains(X, Y)))
        	    return 2;
			else if (_middleRectangle.Contains(X, Y))
        		return 1;
			else
				return -1;
        }

        public Rectangle GetBounds()
        {
            return this._middleRectangle;
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

        #region Extended Functions

        public void SetDestStock(Stock stock, bool ReCalcRect)
        {
            if (stock == null) return;

            stock._inFlow = this;

            this._destination = stock;
            this._endRectangle = null;
            if (!ReCalcRect) return;

            int X, Y;

            Rectangle eRect = this._destination.GetBounds();
            Point point = new Point(eRect.X + eRect.Width / 2, eRect.Y + eRect.Height / 2);
            Point sPoint;
            Rectangle rect;

            if (this._source != null)
            {
                rect = this._source.GetBounds();
            }
            else
            {
                rect = this._startRect.Value;
            }

            sPoint = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);

            X = (sPoint.X + point.X) / 2 - _rectWidth / 2;
            Y = (sPoint.Y + point.Y) / 2 - _rectHeight / 2;

            this._middleRectangle = new Rectangle(X, Y, _rectWidth, _rectHeight);

        }

        public void SetSourceStock(Stock stock, bool ReCalcRect)
        {
            if (stock == null) return;

            stock._outFlow = this;

            this._source = stock;
            this._startRect = null;

            if (!ReCalcRect) return;

            int X, Y;

            Rectangle eRect = stock.GetBounds();
            Point point = new Point(eRect.X + eRect.Width / 2, eRect.Y + eRect.Height / 2);
            Point sPoint;
            Rectangle rect;

            if (this._destination != null)
            {
                rect = this._destination.GetBounds();
            }
            else
            {
                rect = this._endRectangle.Value;
            }

            sPoint = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);

            X = (sPoint.X + point.X) / 2 - _rectWidth / 2;
            Y = (sPoint.Y + point.Y) / 2 - _rectHeight / 2;

            this._middleRectangle = new Rectangle(X, Y, _rectWidth, _rectHeight);
        }

        public void SetDestPoint(Point point, bool ReCalcRect)
        {
            this._endRectangle = new Rectangle(point.X - _rectWidth / 2, point.Y - _rectHeight / 2, _rectWidth, _rectHeight);

            if (this._destination != null)
            {
                this._destination._inFlow = null;
                this._destination = null;
            }

            if (!ReCalcRect) return;

            Point sPoint;
            if (this._source != null)
            {
                Rectangle rect = this._source.GetBounds();
                sPoint = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);
            }
            else
            {
                sPoint = new Point(this._startRect.Value.X + this._startRect.Value.Width / 2, this._startRect.Value.Y + this._startRect.Value.Height / 2);
            }

            int X = Math.Abs(sPoint.X + point.X) / 2 - _rectWidth / 2;
            int Y = Math.Abs(sPoint.Y + point.Y) / 2 - _rectHeight / 2;

            this._middleRectangle = new Rectangle(X, Y, _rectWidth, _rectHeight);
        }

        public void SetSourcePoint(Point point, bool ReCalcRect)
        {
            this._startRect = new Rectangle(point.X - _rectWidth / 2, point.Y - _rectHeight / 2, _rectWidth, _rectHeight);

            if (this._source != null)
            {
                this._source._outFlow = null;
                this._source = null;
            }

            if (!ReCalcRect) return;

            Point sPoint;
            if (this._destination != null)
            {
                Rectangle rect = this._destination.GetBounds();
                sPoint = new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);
            }
            else
            {
                sPoint = new Point(this._endRectangle.Value.X + this._endRectangle.Value.Width / 2, this._endRectangle.Value.Y + this._endRectangle.Value.Height / 2);
            }

            int X = Math.Abs(sPoint.X + point.X) / 2 - _rectWidth / 2;
            int Y = Math.Abs(sPoint.Y + point.Y) / 2 - _rectHeight / 2;

            this._middleRectangle = new Rectangle(X, Y, _rectWidth, _rectHeight);
        }

        #endregion

        #region IRenderable Members

        public string Render()
        {
            string result = _formula;

            foreach (IRenderable item in _refferences)
            {
                if (item is Stock)
                    continue;

                result = result.Replace(item.Name, "(" + item.Render() + ")");
            }
            return result;
        }

        public string GetVariables()
        {
            string result = "";

            foreach (ITransformable item in _refferences)
            {
                if (item is Stock || !(item is IRenderable))
                    continue;

                result = ((IRenderable)item).GetVariables();
            }

            return result;
        }

        public string GetHint()
        {
            return this._name + " : " + this._formula;
        }

        #endregion
    }
}
