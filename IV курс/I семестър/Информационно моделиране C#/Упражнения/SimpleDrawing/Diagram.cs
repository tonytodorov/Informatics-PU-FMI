using System;
using System.Collections.Generic;
using System.Linq;
using System.Drawing;
using System.Windows.Forms;

namespace SimpleDrawing
{
    [Serializable()]
    class ChartObject
    {
        #region Members

        private string _name;
        private List<double> _items;

        private List<PointF> _dots;
        private Color _color;

        #endregion

        #region Propertys

        public List<PointF> Dots
        {
            get { return _dots; }
            set { _dots = value; }
        }

        public Color Color
        {
            get { return _color; }
            set { _color = value; }
        }

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public List<double> Values
        {
            get { return _items; }
            set { _items = value; }
        }

        #endregion

        #region Constructors

        public ChartObject(string name, List<double> items):this()
        {
            this._items = items;
            this._name = name;
        }

        public ChartObject()
        {
        }

        #endregion

        #region functions

        public void ReGenerate(Rectangle rect, double min, double max)
        {
            _dots = new List<PointF>();
            if (this._items == null) return;

            float dx = rect.Width / (this._items.Count - 1);

            float y;

            float x = 0;
            float my = rect.Height / 2;// +rect.Top;
            if (min == 0) min = 0.1;
            if (max == 0) max = 0.1;
            foreach (double value in this._items)
            {
                if (value > 0)
                {

                    y = my - (((float)value / (float)max) * 100) * (float)(((float)rect.Height / 2.0) / 100.0);
                }
                else
                {
                    y = my + (((float)value / (float)min) * 100) * (float)(((float)rect.Height / 2.0) / 100.0);
                }

                _dots.Add(new PointF(dx * x++ + rect.X, y + rect.Y));

            }
        }

        #endregion

    }

    [Serializable()]
    public class Diagram : IDrawable, ITransformable, IEditable, IResizable, ICloneable
    {
        #region Members

        private Rectangle _rect;
        private string _name;

        private List<ChartObject> _items;

        private const string ObjectName = "Diagram ";
        private static int ObjectCount;

        private Size _minSize = new Size(180, 120);

        private int Cells = 6;
        private double? Max = null;
        private bool RecalcNeed = true;

        #endregion

        #region prepertys

        public string Name
        {
            get { return _name; }
        }

        #endregion

        #region Constructors

        public Diagram()
        {
            ObjectCount++;
            this._name = ObjectName + ObjectCount.ToString();
        }

        public Diagram(Rectangle rect):this()
        {
            this._rect = rect;
        }

        public Diagram(Diagram source)
        {
            _rect = source._rect;
            _name = source._name;
            _items = source._items;
            Cells = source.Cells;
            Max = source.Max;
            RecalcNeed = source.RecalcNeed;
        }

        #endregion

        #region IEditable Members

        public object this[string key]
        {
            get
            {
                if (key == "NAME")
                    return _name;
                else
                    return null;
            }

            set
            {
                if (key == "NAME")
                    _name = Convert.ToString(value);
            }
        }

        public List<PropertyDescriptor> GetEditableProperties()
        {
            List<PropertyDescriptor> editableProperties = new List<PropertyDescriptor>();

            editableProperties.Add(new PropertyDescriptor("Name:", "NAME", typeof(String)));

            return editableProperties;
        }

        #endregion

        #region ITransformable Members

        public void Translate(int dX, int dY, int item)
        {
            if (item == 0)
            {
                int newX = dX + _rect.X;
                int newY = dY + _rect.Y;
                _rect = new Rectangle(newX, newY, _rect.Width, _rect.Height);
                RecalcNeed = true;
            }
        }

        public int Contains(int X, int Y)
        {
            int rArea = 4; //px

            Rectangle t, r, d, l, tl, tr, br, bl;

            t = new Rectangle(_rect.Location, new Size(_rect.Width, rArea));
            r = new Rectangle(new Point(_rect.Right,_rect.Top), new Size(rArea, _rect.Height));
            d = new Rectangle(new Point(_rect.Left, _rect.Bottom - rArea), new Size(_rect.Width, rArea));
            l = new Rectangle(_rect.Location, new Size(rArea, _rect.Height));

            tl = new Rectangle(_rect.Location, new Size(rArea, rArea));
            tr = new Rectangle(new Point(_rect.Right - rArea, _rect.Top), new Size(rArea, rArea));
            br = new Rectangle(new Point(_rect.Right - rArea, _rect.Bottom - rArea), new Size(rArea, rArea));
            bl = new Rectangle(new Point(_rect.Left, _rect.Bottom - rArea), new Size(rArea, rArea));

            if (tl.Contains(X, Y))
            {
                return 1;
            }
            else if (tr.Contains(X, Y))
            {
                return 2;
            }
            else if (br.Contains(X, Y))
            {
                return 3;
            }
            else if (bl.Contains(X, Y))
            {
                return 4;
            }
            else if (t.Contains(X, Y))
            {
                return 5;
            }
            else if (r.Contains(X, Y))
            {
                return 6;
            }
            else if (d.Contains(X, Y))
            {
                return 7;
            }
            else if (l.Contains(X, Y))
            {
                return 8;
            }
            return _rect.Contains(X, Y) ? 0 : -1;
        }

        public Rectangle GetBounds()
        {
            return this._rect;
        }

        #endregion

        #region IDrawable Members

        public void Draw(object sender, Graphics g, params Brush[] colours)
        {/*
            int X ,Y;
            X = Y = this._margin;
            int Count = 0;
            int flows = 0;
            
            if (this._values != null)
            {
                flows = this._values[this._values.Keys.First()].Count;
                Count = this._values.Keys.Count;
            }

            using (Pen pen = new Pen(Color.Black, 2))
            {
                
                g.FillRectangle(Brushes.Green, _rect);
                g.DrawRectangle(pen, _rect);

                while (X < _rect.Width - _margin*2)
                {
                    g.FillRectangle(Brushes.Black, new Rectangle(_rect.Left + X, _rect.Bottom - _margin, 2, 2));
                    X += _stepX;
                }
                while (Y < _rect.Height - _margin*2)
                {
                    g.FillRectangle(Brushes.Black, new Rectangle(_rect.Left + _margin, (_rect.Bottom - _margin) - Y, 2, 2));
                    Y += _stepY;
                }
                
                int height = this._rect.Height - _margin *2;
                int width = this._rect.Width - _margin *2;
                double py = 0;

                if (this._values != null)
                {
                    foreach (string key in this._values.Keys)
                    {
                        Point[] pts = new Point[flows];
                        if (this._maxYVal == 0.0) break;
                        for (int f = 0; f < flows; f++)
                        {
                            py = (this._values[key][f] / this._maxYVal) * 100;
                            py = (((double)height) / 100) * py;
                            pts[f] = new Point(this._rect.Left + f * _stepX + _margin, this._rect.Bottom - _margin - (int)py);
                        }
                        g.DrawLines(pen, pts);
                    }
                }
            }*/
            DrawBackground(g);
        }

        #endregion

        #region Functions

        public void PopulateDiagram(List<Dictionary<string, List<double>>> source)
        {
            this._items = new List<ChartObject>();
            if (source == null || source.Count == 0) return;
            Random rand = new Random();

            foreach (Dictionary<string, List<double>> dct in source)
            {
                foreach (string key in dct.Keys)
                {
                    ChartObject obj = new ChartObject(key, dct[key]);
                    obj.Color = Color.FromArgb(rand.Next(254), rand.Next(254), rand.Next(254));
                    this._items.Add(obj);
                }
            }

            double min = 0, max = 0;
            MinMaxValue(out min, out max);
            Max = Math.Max(Math.Abs(min), Math.Abs(max));
        }

        private void MinMaxValue(out double min, out double max)
        {
            if (_items == null)
            {
                min = max = 0;
            }
            else
            {
                min = max = 0;
                double ibuf, abuf;
                foreach (ChartObject obj in this._items)
                {
                    ibuf = obj.Values.Min();
                    abuf = obj.Values.Max();

                    min = min < ibuf ? min : ibuf;
                    max = max > abuf ? max : abuf;
                }
            }
        }

        private bool IsCorrectSize(Rectangle rect)
        {
            //return (rect.Width > _minSize.Width && rect.Height > _minSize.Height);
            return true;
        }

        private Point Mid(Rectangle rect)
        {
            return new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);
        }

        public void SetRectangle(Rectangle rect)
        {
            this._rect = rect;
            this.RecalcNeed = true;
        }

        #endregion

        #region PaintFunctions

        private void DrawBackground(Graphics g)
        {
            int i,x,y;
            double bfr;
            Rectangle rect = _rect;
            double min = 0, max = 0;
            rect.Size -= new Size(120, 60);
            if (Max == null)
            {
                MinMaxValue(out min, out max);
                Max = Math.Max(Math.Abs(min), Math.Abs(max));
            }

            if (this.Cells == 0) this.Cells = 6;

            int Iteration = 10;

            if(this._items != null)
                Iteration = this._items.Count > 0 ? this._items[0].Values.Count : 0;

            rect.Location = new Point(rect.X + 100, rect.Y + 40);
            while (rect.Width % this.Cells != 0)
            {
                rect.Width -= 1;
            }
            while (rect.Height % this.Cells != 0)
            {
                rect.Height -= 1;
            }
            Point m = Mid(rect);

            StringFormat tf = new StringFormat();
            tf.LineAlignment = StringAlignment.Near;
            tf.Alignment = StringAlignment.Center;

            // background
            g.FillRectangle(Brushes.WhiteSmoke, _rect);
            using (Font tFont = new Font("Tahoma", 8))
            {
                using (Pen pn = new Pen(Color.Black, 2))
                {
                    g.DrawRectangle(pn, _rect);
                    if (this._name != "")
                        g.DrawString(this._name, tFont, Brushes.Black, new Point(Mid(_rect).X, _rect.Y), tf);

                    g.DrawLine(pn, rect.Location, new Point(rect.X, rect.Y + rect.Height));
                    g.DrawLine(pn, rect.X, m.Y, rect.X + rect.Width, m.Y);
                    using (Pen pdd = new Pen(Color.Thistle))
                    {
                        pdd.DashStyle = System.Drawing.Drawing2D.DashStyle.DashDot;

                        tf.LineAlignment = StringAlignment.Near;
                        tf.Alignment = StringAlignment.Center;

                        for (i = 1; i <= Cells; i++)
                        {
                            x = rect.X + (rect.Width / Cells) * i;
                            g.DrawLine(pdd, new Point(x, rect.Y), new Point(x, rect.Y + rect.Height));
                            if (Iteration != 0)
                                g.DrawString(Math.Round(i * ((double)Iteration / (double)Cells),1).ToString(), tFont, Brushes.Black, x, rect.Y + rect.Height / 2, tf);
                        }

                        tf.LineAlignment = StringAlignment.Center;
                        tf.Alignment = StringAlignment.Far;

                        for (i = 0; i <= Cells * 2; i++)
                        {
                            if (i == Cells) // 0 ?
                            {
                                g.DrawString("0", tFont, Brushes.Black, rect.X, m.Y, tf);
                            }
                            else
                            {
                                x = rect.X;
                                y = rect.Y + (rect.Height / (Cells * 2)) * i;
                                g.DrawLine(pdd, new Point(x, y), new Point(x + rect.Width, y));
                                if (Max != null & Max.Value != 0)
                                {
                                    bfr = Max.Value - ((Max.Value / Cells) * i);
                                    g.DrawString(Math.Round(bfr).ToString(), tFont, Brushes.Black, new Point(x, y), tf);
                                }
                            }
                        }

                        if (this._items != null)
                        {
                            PointF[] points;
                            y = rect.Y;
                            bool getMinMax = true;
                            tf.Alignment = StringAlignment.Near;

                            foreach (ChartObject item in _items)
                            {
                                if (this.RecalcNeed || item.Dots == null)
                                {
                                    if (getMinMax)
                                    {
                                        MinMaxValue(out min, out max);
                                        getMinMax = false;
                                    }
                                    item.ReGenerate(rect, min, max);
                                }

                                using (Pen iPen = new Pen(item.Color))
                                {
                                    using (Brush iBrush = new SolidBrush(item.Color))
                                    {
                                        points = item.Dots.ToArray();
                                        g.DrawLines(iPen, points);
                                        foreach (PointF pt in points)
                                        {
                                            g.FillEllipse(iBrush, pt.X - 2, pt.Y - 2, 3, 3);
                                        }
                                        g.DrawString(item.Name, tFont, iBrush, _rect.X + 2, y, tf);
                                        y += 10;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        #endregion

        #region IResizable Members

        public bool Resize(int x, int y, int Index)
        {
            Rectangle buffer = _rect;

            switch (Index)
            {
                case 1:
                    buffer.Offset(x, y);
                    buffer.Width += x < 0 ? Math.Abs(x) : -x;
                    buffer.Height += y < 0 ? Math.Abs(y) : -y;
                    break;
                case 2:
                    buffer.Offset(0, y);
                    buffer.Width += x;
                    buffer.Height += y < 0 ? Math.Abs(y) : -y;
                    break;
                case 3:
                    buffer.Width += x;
                    buffer.Height += y;
                    break;
                case 4:
                    buffer.Offset(x, 0);
                    buffer.Width += x < 0 ? Math.Abs(x) : -x;
                    buffer.Height += y;
                    break;
                case 5:
                    buffer.Offset(0, y);
                    buffer.Height += y;
                    break;
                case 6:
                    buffer.Width += x;
                    break;
                case 7:
                    buffer.Height += y;
                    break;
                case 8:
                    buffer.Offset(x, 0);
                    buffer.Width += x < 0 ? Math.Abs(x) : -x;
                    break;
            }

            this.RecalcNeed = true;

            if (IsCorrectSize(buffer))
            {
                _rect = buffer;
                return true;
            }
            return false;
        }

        public Cursor GetCursor(int Index)
        {
            switch (Index)
            {
                case 1:
                    return Cursors.SizeNWSE;
                case 5:
                    return Cursors.SizeNS;
                case 2:
                    return Cursors.SizeNESW;
                case 6:
                    return Cursors.SizeWE;
                case 3:
                    return Cursors.SizeNWSE;
                case 7:
                    return Cursors.SizeNS;
                case 4:
                    return Cursors.SizeNESW;
                case 8:
                    return Cursors.SizeWE;
                default:
                    return Cursors.Default;
            }
        }

        #endregion

        #region ICloneable Members

        public object Clone()
        {
            return new Diagram(this);
        }

        #endregion
    }
}
