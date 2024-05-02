using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using System.Data;

namespace SimpleDrawing
{
    [Serializable()]
    class ResultTable : IDrawable, ITransformable, IEditable, IDisposable, IResizable
    {
        #region Members

        private Rectangle _rect;
        private string _name;

        [NonSerialized]
        private DataGridView _grid;

        private const int _paddingTop = 24;
        private const int _padding = 8;

        private DataTable _table;
        private int _topAdd = 0;
        private bool _drag;

        private const string ObjectName = "Result Table ";
        private static int ObjectCount;

        private Size _minSize = new Size(180, 120);

        #endregion

        public string Name
        {
            get { return _name; }
        }

        #region Constructors

        public ResultTable()
        {
            this._grid = new DataGridView();
            ObjectCount++;
            this._name = ObjectName + ObjectCount.ToString();
        }

        public ResultTable(Control parent, Rectangle rect)
            : this()
        {
            this._grid.Parent = parent;
            this._rect = rect;

            this.RefresgGridBounds();
            this._grid.BringToFront();
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
                RefresgGridBounds();
            }
        }

        public int Contains(int X, int Y)
        {
            int rArea = 4; //px

            Rectangle t, r, d, l, tl, tr, br, bl;

            t = new Rectangle(_rect.Location, new Size(_rect.Width, rArea));
            r = new Rectangle(new Point(_rect.Right, _rect.Top), new Size(rArea, _rect.Height));
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

        public void Draw(object sender, Graphics g, params Brush[] colour)
        {
            StringFormat tf = new StringFormat();
            tf.LineAlignment = StringAlignment.Near;
            tf.Alignment = StringAlignment.Center;
            using (Font fnt = new Font("Tahoma", 10))
            {
                using (Pen pen = new Pen(Color.Black, 2))
                {
                    if (!this._drag)
                        g.FillRectangle(Brushes.Honeydew, _rect);

                    g.DrawRectangle(pen, _rect);

                    g.DrawString(this._name, fnt, Brushes.Black, _rect.X + _rect.Width / 2, _rect.Y, tf);
                }
            }
            if (this._grid == null)
            {
                Control snd = sender as Control;
                if (snd == null) return;
                    UpdateGrid(snd);
            }        
        }

        #endregion

        #region Functions

        private void RefresgGridBounds()
        {
            this._grid.Width = this._rect.Width - _padding * 2;
            this._grid.Height = this._rect.Height - (_padding + _paddingTop);
            this._grid.Top = this._rect.Top + _paddingTop + _topAdd;
            this._grid.Left = this._rect.Left + _padding;
        }

        private void UpdateGrid(Control parent)
        {
            this._grid = new DataGridView();
            this._grid.Parent = parent.Parent;
            this._grid.BringToFront();
            _topAdd = parent.Top;
            this.RefresgGridBounds();

            if (this._table != null)
            {
                this._grid.DataSource = _table;
            }
        }

        public void PopulateGrid(List<Dictionary<string, List<double>>> source)
        {
            _table = new DataTable();

            DataColumn column;
            DataRow row;

            List<List<double>> buff = new List<List<double>>();
            List<string> columns = new List<string>();

            foreach (Dictionary<string, List<double>> item in source)
            {
                foreach (KeyValuePair<string, List<double>> vls in item)
                {
                    column = new DataColumn();
                    column.DataType = typeof(double);
                    column.ColumnName = vls.Key;
                    column.ReadOnly = true;
                    column.Unique = false;
                    _table.Columns.Add(column);
                    buff.Add(vls.Value);
                    columns.Add(vls.Key);
                }
            }

            if (buff.Count > 0)
            {
                for (int r = 0; r < buff[0].Count; r++)
                {
                    row = _table.NewRow();
                    for (int ii = 0; ii < columns.Count; ii++)
                    {
                        row[ii] = buff[ii][r];
                    }
                    _table.Rows.Add(row);
                }
            }
            this._grid.DataSource = _table;
        }

        public void BeginDrag()
        {
            this._grid.Hide();
            this._drag = true;
        }

        public void EndDrag()
        {
            this._grid.Show();
            this._drag = false;
        }

        private bool IsCorrectSize(Rectangle rect)
        {
            return (rect.Width > _minSize.Width && rect.Height > _minSize.Height);
        }

        #endregion

        #region IDisposable Members

        public void Dispose()
        {
            this._grid.Dispose();
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
                    buffer.Height -= y;
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

            if (IsCorrectSize(buffer))
            {
                _rect = buffer;
                RefresgGridBounds();
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
    }
}
