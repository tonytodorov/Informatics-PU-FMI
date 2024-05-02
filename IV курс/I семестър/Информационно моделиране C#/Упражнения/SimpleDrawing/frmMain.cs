using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.Serialization.Formatters.Binary;
using System.Drawing.Drawing2D;
using System.Text.RegularExpressions;

namespace SimpleDrawing
{
    public partial class frmMain : Form
    {

        #region Constructors

        public frmMain()
        {
            InitializeComponent();

        }

        #endregion

        #region Members

        List<IDrawable> _items = new List<IDrawable>();

        int _selectedIndex = -1;
        int _selectedItem = -1;
        int _cursorItem = -1;

        private IDrawable selectedItem;

        int _X, _Y;
        IConnectable start = null;

        Point? _startPoint = null;
        Point _mousePoint;
        Flow _flow = null;
        ITransformable _reff;
        IDrawable _menuItem;

        List<Dictionary<string, List<double>>> _values;

        #endregion

        #region simulation

        private void Run(double step, int time)
        {
            StringBuilder equation = new StringBuilder("");
            foreach (IDrawable var in _items)
            {
                if (var is Stock)
                {
                    Stock tStock;
                    tStock = (Stock)var;
                    equation.Append(tStock.Render() + '\n');
                }
                if (var is Flow)
                {
                    Flow tFlow;
                    tFlow = (Flow)var;
                    equation.Append(tFlow.Name + '=' + tFlow.Forumla + '\n');
                }
                if (var is Coefficient)
                {
                    Coefficient tCoefficient;
                    tCoefficient = (Coefficient)var;
                    //equation.Append(tCoefficient.Render() + '\n');
                    equation.Append(tCoefficient.Name + '=' + tCoefficient.Formula + '\n');
                }


            }

            if (ValidateInputForEquationSolver(equation.ToString(), step.ToString(), time.ToString(), 1.ToString()))
            {
                _values = Simulation.SolveEquation(equation.ToString(), step, time, 1);

                int cnt = 0;

                Dictionary<Dictionary<string, List<double>>, List<string>> toRemove = new Dictionary<Dictionary<string, List<double>>, List<string>>();

                foreach (Dictionary<string, List<double>> item in _values)
                {
                    foreach (string key in item.Keys)
                    {
                        if (cnt < item[key].Count) cnt = item[key].Count;
                    }
                }

                foreach (Dictionary<string, List<double>> item in _values)
                {
                    List<string> buf = new List<string>();

                    foreach (KeyValuePair<string, List<double>> vls in item)
                    {
                        if (item[vls.Key].Count < cnt)
                        {
                            buf.Add(vls.Key);
                        }
                    }
                    if (buf.Count > 0) toRemove.Add(item, buf);
                }

                foreach (KeyValuePair<Dictionary<string, List<double>>, List<string>> vls in toRemove)
                {
                    foreach (string key in vls.Value)
                        vls.Key.Remove(key);
                }
            }
            else
            {
                MessageBox.Show("Incorrect input! Check the StartPoint, Step and Time input.");
            }
        }

        #endregion

        #region Event Handlers

        //toolStripMenu Toggle Buttons Behaviour implementation
        private void tsMenu_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (e.ClickedItem is ToolStripButton)
            {
                foreach (ToolStripItem button in this.tsMenu.Items)
                    if (button is ToolStripButton)
                        ((ToolStripButton)button).CheckState = CheckState.Unchecked;

                ((ToolStripButton)e.ClickedItem).CheckState = CheckState.Checked;
            }
        }

        private void SetMenuSelectButton()
        {
            foreach (ToolStripItem button in this.tsMenu.Items)
                if (button is ToolStripButton)
                    if (((ToolStripButton)button).Text == "Select")
                        ((ToolStripButton)button).CheckState = CheckState.Checked;
                    else
                        ((ToolStripButton)button).CheckState = CheckState.Unchecked;
        }

        //_items drawing
        private void pbDashboard_Paint(object sender, PaintEventArgs e)
        {
            foreach (IDrawable item in this._items)
            {
               
                   item.Draw(sender, e.Graphics);
                

            }

            if (this._flow != null)
            {
                _flow.Draw(sender, e.Graphics);
            }

            if (this._reff != null)
            {
                e.Graphics.DrawLine(Pens.Blue, Middle(this._reff.GetBounds()), this._mousePoint);
            }
        }

        private ITransformable getItem(Point p)
        {
            foreach (ITransformable item in this._items)
                if (item.Contains(p.X, p.Y) != -1)
                {
                    return item;
                }
            return null;
        }

        private void MenuDeleteInFlow(object sender, EventArgs e)
        {
            if (_menuItem == null) return;
            Flow fl = _menuItem as Flow;
            if (fl != null)
            {
                if (fl._source != null)
                    fl.SetSourcePoint(Middle(fl._source.GetBounds()), false);
            }
            else if (_menuItem is Stock)
            {
                if (((Stock)_menuItem).InFlow != null)
                    ((Stock)_menuItem).InFlow.SetDestPoint(Middle(((Stock)_menuItem).GetBounds()), false);
            }
            pbDashboard.Refresh();
        }
        private void ClearBoard(object sender, EventArgs e)
        {
            this.CleanUp();
            pbDashboard.Refresh();
        }

        private void MenuDeleteOutFlow(object sender, EventArgs e)
        {
            if (_menuItem == null) return;
            Flow fl = _menuItem as Flow;
            if (fl != null)
            {
                if (fl._destination != null)
                    fl.SetDestPoint(Middle(fl._destination.GetBounds()), false);
            }
            else if (_menuItem is Stock)
            {
                if (((Stock)_menuItem).OutFlow != null)
                    ((Stock)_menuItem).OutFlow.SetSourcePoint(Middle(((Stock)_menuItem).GetBounds()), false);
            }

            pbDashboard.Refresh();
        }

        private void MenuDeleteRefference(object sender, EventArgs e)
        {
            if (_menuItem == null) return;

            foreach (IDrawable item in _items)
            {
                if (item is IConnectable)
                {
                    ((IConnectable)item).Refferences.Remove((ITransformable)_menuItem);
                }
            }
            pbDashboard.Refresh();
        }
        private void MenuEditColor(object sender, EventArgs e)
        {

            if (dlgColour.ShowDialog() == DialogResult.OK)
            {
               if(selectedItem != null && selectedItem is Stock)
                {
                    (selectedItem as Stock).color = new SolidBrush(dlgColour.Color);
                }
                else if (selectedItem != null && selectedItem is Coefficient)
                {
                    (selectedItem as Coefficient).Border = new SolidBrush(dlgColour.Color);
                }
                pbDashboard.Refresh();
            }
        }

        private void MenuDeleteObject(object sender, EventArgs e)
        {
            if (_menuItem == null) return;

            MenuDeleteRefference(sender, e);

            if (_menuItem is Stock)
            {
                MenuDeleteOutFlow(sender, e);
                MenuDeleteInFlow(sender, e);
            }
            _items.Remove(_menuItem);
            pbDashboard.Refresh();
        }


        private void MenuEditObject(object sender, EventArgs e)
        {
            if (_menuItem == null) return;

            if (_menuItem is IEditable)
            {
                frmEditIEditable editor = new frmEditIEditable((IEditable)_menuItem, this);
                editor.ShowDialog();


            }
            pbDashboard.Refresh();
        }

        private void MenuDiagramForm(object sender, EventArgs e)
        {
            if (_menuItem == null) return;

            if (_menuItem is Diagram)
            {
                frmDiagram dForm = new frmDiagram((Diagram)_menuItem);
                dForm.ShowDialog();
            }
            pbDashboard.Refresh();
        }

        //_items manupulation
        private void pbDashboard_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                pbMenu.Items.Clear();
                Point pt = new Point(e.X, e.Y);
                _menuItem = getItem(pt) as IDrawable;

                if (_menuItem == null)
                {
                    pbMenu.Items.Add("CLEAR ALL");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources.delete;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.ClearBoard);

                    selectedItem = null;
                    //return;
                }

                else if (_menuItem is Stock)
                {
                    Stock stk = _menuItem as Stock;
                    selectedItem = stk;
                    if (stk._inFlow != null)
                    {
                        pbMenu.Items.Add("Detach In Flow: " + stk._inFlow.Name);
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteInFlow);
                    }
                    if (stk._outFlow != null)
                    {
                        pbMenu.Items.Add("Detach Out Flow: " + stk._outFlow.Name);
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteOutFlow);
                    }
                    if (stk.Refferences.Count > 0)
                    {
                        pbMenu.Items.Add("Detach Refferences");
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteRefference);
                    }

                    pbMenu.Items.Add("Edit Object");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._001_tools;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditObject);

                    pbMenu.Items.Add("Edit Colour");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._003_pantone;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditColor);

                    if (pbMenu.Items.Count > 0)
                        pbMenu.Items.Add("-");

                    pbMenu.Items.Add("Delete " + stk.Name);
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources.delete;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteObject);
                }
                else if (_menuItem is Flow)
                {
                    selectedItem = null;

                    Flow fl = _menuItem as Flow;
                    if (fl._source != null)
                    {
                        pbMenu.Items.Add("Detach Flow: " + fl._source.Name);
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteInFlow);
                    }
                    if (fl._destination != null)
                    {
                        pbMenu.Items.Add("Detach Flow: " + fl._destination.Name);
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteOutFlow);
                    }
                    if (fl.Refferences.Count > 0)
                    {
                        pbMenu.Items.Add("Detach Refferences");
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteRefference);
                    }

                    pbMenu.Items.Add("Edit Object");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._001_tools;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditObject);

                    if (pbMenu.Items.Count > 0)
                        pbMenu.Items.Add("-");

                    pbMenu.Items.Add("Delete " + fl.Name);
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources.delete;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteObject);
                }
                else if (_menuItem is Coefficient)
                {
                    selectedItem = _menuItem;
                    Coefficient fl = _menuItem as Coefficient;
                    if (fl.Refferences.Count > 0)
                    {
                        pbMenu.Items.Add("Detach Refferences");
                        pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteRefference);
                    }

                    pbMenu.Items.Add("Edit Object");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._001_tools;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditObject);

                    pbMenu.Items.Add("Edit Border Colour");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._003_pantone;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditColor);

                    if (pbMenu.Items.Count > 0)
                        pbMenu.Items.Add("-");

                    pbMenu.Items.Add("Delete " + fl.Name);
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources.delete;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteObject);
                }
                else if (_menuItem is ResultTable)
                {
                    selectedItem = null;

                    ResultTable fl = _menuItem as ResultTable;
                    pbMenu.Items.Add("Edit Object");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._001_tools;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditObject);

                    if (pbMenu.Items.Count > 0)
                        pbMenu.Items.Add("-");

                    pbMenu.Items.Add("Delete " + fl.Name);
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources.delete;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteObject);
                }
                else if (_menuItem is Diagram)
                {
                    selectedItem = null;

                    Diagram fl = _menuItem as Diagram;
                    pbMenu.Items.Add("Show in new form");
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDiagramForm);

                    pbMenu.Items.Add("Edit Object");
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources._001_tools;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuEditObject);

                    if (pbMenu.Items.Count > 0)
                        pbMenu.Items.Add("-");

                    pbMenu.Items.Add("Delete " + fl.Name);
                    pbMenu.Items[pbMenu.Items.Count - 1].Image = Properties.Resources.delete;
                    pbMenu.Items[pbMenu.Items.Count - 1].Click += new EventHandler(this.MenuDeleteObject);
                }

                pbMenu.Show(pbDashboard, pt);
            }

            if (e.Button != MouseButtons.Left)
                return;

            Cursor.Clip = new Rectangle(this.PointToScreen(this.pbDashboard.Location), this.pbDashboard.Size);

            this.pbDashboard.Capture = true;

            if (btnStock.CheckState == CheckState.Checked)
            {
                this._items.Add(new Stock(new Rectangle(e.X - 50, e.Y - 25, 100, 50)));
                this.pbDashboard.Refresh();
                SetMenuSelectButton();
            }
            else if (tsbDiagram.CheckState == CheckState.Checked)
            {
                this._items.Add(new Diagram(new Rectangle(e.X - 250, e.Y - 125, 500, 250)));
                this.pbDashboard.Refresh();
                SetMenuSelectButton();
            }
            else if (tsbResultTable.CheckState == CheckState.Checked)
            {
                this._items.Add(new ResultTable(this.pbDashboard, new Rectangle(e.X - 150, e.Y - 100, 300, 200)));
                this.pbDashboard.Refresh();
                SetMenuSelectButton();
            }
            else if (btnFlow.CheckState == CheckState.Checked)
            {
                if (_startPoint == null)
                {
                    _startPoint = new Point(e.X, e.Y);
                    Rectangle rect;
                    ITransformable sItem = getItem(_startPoint.Value);
                    rect = new Rectangle(_startPoint.Value.X, _startPoint.Value.Y, 10, 10);

                    if (sItem != null && sItem is Stock && ((Stock)sItem).InFlow == null)
                    {
                        this._flow = new Flow((Stock)sItem, rect);
                        ((Stock)sItem).OutFlow = this._flow;
                    }
                    else
                    {
                        this._flow = new Flow(rect, new Rectangle(e.X, e.Y, 10, 10));
                    }
                }
                else
                {
                    Point EndPoint = new Point(e.X, e.Y);
                    ITransformable sItem = getItem(_startPoint.Value);
                    ITransformable eItem = getItem(EndPoint);

                    this._items.Add(this._flow);
                    this.pbDashboard.Refresh();

                    this._startPoint = null;
                    this._flow = null;
                    SetMenuSelectButton();
                }
            }
            else if (btnCoefficient.CheckState == CheckState.Checked)
            {
                this._items.Add(new Coefficient(new Rectangle(e.X - 25, e.Y - 25, 50, 50)));
                this.pbDashboard.Refresh();
                SetMenuSelectButton();
            }
            else if (btnRefference.CheckState == CheckState.Checked)
            {
                if (_reff == null)
                {
                    _reff = getItem(new Point(e.X, e.Y));
                    if (_reff is Diagram || _reff is ResultTable || !(_reff is IConnectable)) _reff = null;
                    if (_reff == null) return;
                }
                else
                {
                    IConnectable cnt = getItem(new Point(e.X, e.Y)) as IConnectable;
                    if (cnt == null || cnt == _reff)
                    {
                        _reff = null;
                        SetMenuSelectButton();
                        return;
                    }
                    cnt.Connect((IConnectable)_reff);
                    _reff = null;
                    SetMenuSelectButton();
                }

                /*
                foreach (ITransformable item in this._items)
                    if (item.Contains(e.X, e.Y) != -1)
                    {
                        _selectedItem = item.Contains(e.X, e.Y);
                        _selectedIndex = this._items.IndexOf((IDrawable)item);
                        break;
                    }
                
                if (_selectedIndex == -1)
                    this.start = null;
                else if (this.start == null)
                    this.start = (IConnectable)_items[_selectedIndex];
                else
                {
                    this.start.Connect((IConnectable)_items[_selectedIndex]);
                    this.start = null;
                }

                this._selectedIndex = -1;
                 */
                this.pbDashboard.Refresh();
            }
            else if (btnSelect.CheckState == CheckState.Checked)
            {
                foreach (ITransformable item in this._items)
                    if (item.Contains(e.X, e.Y) != -1)
                    {
                        _selectedItem = item.Contains(e.X, e.Y);
                        _cursorItem = _selectedIndex;
                        _selectedIndex = this._items.IndexOf((IDrawable)item);
                        if (item is ResultTable)
                        {
                            ((ResultTable)item).BeginDrag();
                        }
                        break;
                    }
                this._X = e.X;
                this._Y = e.Y;
            }
        }

        private void pbDashboard_MouseMove(object sender, MouseEventArgs e)
        {
            _mousePoint = new Point(e.X, e.Y);
            if (btnRefference.CheckState == CheckState.Checked)
            {
                //  _DestinationRefferencePt = new Point(e.X, e.Y);
                pbDashboard.Refresh();
            }

            if (this._selectedIndex != -1)
            {
                int dX, dY;
                dX = e.X - this._X;
                dY = e.Y - this._Y;
                this._X = e.X;
                this._Y = e.Y;
                if (this._items[this._selectedIndex] is IResizable && this._selectedItem != 0)
                {
                    if (!((IResizable)this._items[this._selectedIndex]).Resize(dX, dY, this._selectedItem))
                    {
                        Cursor.Position = _mousePoint;
                    }
                }
                if (this._items[this._selectedIndex] is Flow)
                {
                    Flow fl = (Flow)this._items[this._selectedIndex];

                    IRenderable itm = getitemex(e.X, e.Y, this._items[this._selectedIndex]);

                    switch (this._selectedItem)
                    {
                        case 2:
                            if (itm != null && itm is Stock && fl._source != itm && ((Stock)itm)._inFlow == null)
                            {
                                if (fl._source == null)
                                    fl.SetDestStock((Stock)itm, false);
                                else
                                    fl.SetDestPoint(_mousePoint, false);
                            }
                            else
                            {
                                if (itm == null || fl._destination != itm)
                                    fl.SetDestPoint(_mousePoint, false);
                            }
                            pbDashboard.Refresh();

                            return;
                        case 0:
                            if (itm != null && itm is Stock && fl._destination != itm && ((Stock)itm)._outFlow == null)
                            {
                                if (fl._destination == null)
                                    fl.SetSourceStock((Stock)itm, false);
                                else
                                    fl.SetSourcePoint(_mousePoint, false);
                            }
                            else
                            {
                                if (itm == null || fl._source != itm)
                                    fl.SetSourcePoint(_mousePoint, false);
                            }
                            pbDashboard.Refresh();

                            return;
                    }

                }
                ((ITransformable)this._items[this._selectedIndex]).Translate(dX, dY, this._selectedItem);
                this.pbDashboard.Refresh();
            }
            else if (this.start != null)
            {
                this.pbDashboard.Refresh();
                Graphics g = this.pbDashboard.CreateGraphics();
                Rectangle sRect = ((ITransformable)start).GetBounds();
                Point sPoint = new Point(sRect.X + sRect.Width / 2, sRect.Y + sRect.Height / 2);
                g.DrawLine(new Pen(Color.Red), sPoint, new Point(e.X, e.Y));
            }
            else if (this._startPoint != null)
            {

                ITransformable item = (ITransformable)getItem(_mousePoint);
                if (item != null && item is Stock && this._flow._source != item && ((Stock)item)._inFlow == null)
                {
                    this._flow.SetDestStock((Stock)item, true);
                    ((Stock)item)._inFlow = this._flow;
                    this.pbDashboard.Refresh();
                }
                else
                {
                    if (item == null)
                    {
                        this._flow.SetDestPoint(_mousePoint, true);
                        if (this._flow._destination != null)
                        {
                            this._flow._destination._outFlow = null;
                            this._flow._destination = null;
                        }
                    }
                    else
                    {
                        if (item != this._flow._destination)
                            this._flow.SetDestPoint(_mousePoint, true);
                    }
                    this.pbDashboard.Refresh();
                }
            }
            if (this._cursorItem == -1 && btnSelect.CheckState == CheckState.Checked)
            {
                while (true)
                {
                    ITransformable item = getItem(new Point(e.X, e.Y));
                    if (item == null || !(item is IResizable)) break;

                    int cnt = item.Contains(e.X, e.Y);
                    if (cnt < 1) break;
                    this.pbDashboard.Cursor = ((IResizable)item).GetCursor(cnt);
                    return;
                }
                this.pbDashboard.Cursor = Cursors.Default;
                IRenderable it = getItem(new Point(e.X, e.Y)) as IRenderable;
                if (it != null)
                {
                    if (sbLabel1.Tag == it) return;
                    sbLabel1.Text = it.GetHint();
                    sbLabel1.Tag = it;
                }
                else
                {
                    if (sbLabel1.Tag != null)
                    {
                        sbLabel1.Tag = null;
                        sbLabel1.Text = "";
                    }
                }
            }
            else
            {
                this.pbDashboard.Cursor = Cursors.Default;
            }
        }

        private IRenderable getitemex(int x, int y, IDrawable iDrawable)
        {
            foreach (ITransformable item in this._items)
                if (item is IRenderable && item.Contains(x, y) != -1)
                {
                    if (item != iDrawable)
                        return (IRenderable)item;
                }
            return null;
        }

        private void pbDashboard_MouseUp(object sender, MouseEventArgs e)
        {
            if (this._selectedIndex != -1)
            {
                if (this._items[this._selectedIndex] is ResultTable)
                {
                    ((ResultTable)this._items[this._selectedIndex]).EndDrag();
                    this.pbDashboard.Refresh();
                }
                this._selectedIndex = -1;
            }

            this.pbDashboard.Capture = false;

            Cursor.Clip = Screen.PrimaryScreen.Bounds;
        }

        //Fast keys
        private void frmMain_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && (e.KeyCode == Keys.S))
            {
                tsMenu_ItemClicked(tsMenu, new ToolStripItemClickedEventArgs(btnSelect));
            }
        }

        //Edit IEditable item
        private void pbDashboard_DoubleClick(object sender, EventArgs e)
        {
            if (btnSelect.Checked && (_selectedIndex > -1))
            {
                if (_items[_selectedIndex] is IEditable)
                {
                    frmEditIEditable editor = new frmEditIEditable((IEditable)_items[_selectedIndex], this);
                    editor.ShowDialog();
                }
            }
        }

        #endregion

        private void btnRun_Click(object sender, EventArgs e)
        {

        }

        private void UpdateTablesAndDiagrams()
        {
            if (this._values == null || this._values.Count == 0) return;

            foreach (IDrawable item in _items)
            {
                if (item is ResultTable)
                {
                    ((ResultTable)item).PopulateGrid(this._values);
                }
                else if (item is Diagram)
                {
                    ((Diagram)item).PopulateDiagram(this._values);
                }
            }
        }

        private void CleanUp()
        {
            foreach (IDrawable item in _items)
            {
                if (item is ResultTable)
                {
                    ((ResultTable)item).Dispose();
                }
            }
            this._items = new List<IDrawable>();
        }

        private Point Middle(Rectangle rect)
        {
            return new Point(rect.X + rect.Width / 2, rect.Y + rect.Height / 2);
        }

        #region load/save

        private void ItemsSave(string filename)
        {
            using (System.IO.FileStream str = new System.IO.FileStream(filename, System.IO.FileMode.Create))
            {
                BinaryFormatter serializer = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                serializer.Serialize(str, _items);
            }
        }

        private void ItemsLoad(string filename)
        {
            CleanUp();
            using (System.IO.FileStream str = new System.IO.FileStream(filename, System.IO.FileMode.Open))
            {
                BinaryFormatter deserializer =
                new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
                _items = (List<IDrawable>)deserializer.Deserialize(str);
                str.Close();
            }
        }

        private void saveToolStripButton_Click(object sender, EventArgs e)
        {
            if (dlgSave.ShowDialog(this) == DialogResult.OK)
            {
                ItemsSave(dlgSave.FileName);
            }
        }

        private void openToolStripButton_Click(object sender, EventArgs e)
        {
            if (dlgOpen.ShowDialog(this) == DialogResult.OK)
            {
                ItemsLoad(dlgOpen.FileName);
                this.pbDashboard.Refresh();
            }
        }

        #endregion

        private void newToolStripButton_Click(object sender, EventArgs e)
        {
            this.CleanUp();
            this.pbDashboard.Refresh();
        }

        private void pbDashboard_Click(object sender, EventArgs e)
        {

        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void runToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DummyObj obj = new DummyObj();
            frmRun fRun = new frmRun(obj);
            if (fRun.ShowDialog() == DialogResult.OK)
            {
                Run(obj.Step, obj.Iteration);
                UpdateTablesAndDiagrams();
                this.pbDashboard.Refresh();
            }
        }

        private bool ValidateInputForEquationSolver(String equation, String step, String time, String startPoint)
        {
            // for now the string input for the equation is not being checked
            // TODO: validate the equation!!!
            return IsPositiveNumber(step.ToString()) && IsPositiveNumber(time.ToString()) && IsPositiveNumber(startPoint.ToString());
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            this.Icon = Properties.Resources.icon;
            this.BackColor = Color.Beige;
            this.AutoSize = false;
            this.Size = new Size(600, 500);
            dlgColour.Color = Color.Blue;

            btnSelect.Image = Properties.Resources._004_selection;
            btnSelect.TextImageRelation = TextImageRelation.ImageBeforeText;
            btnSelect.AutoSize = false;
            btnSelect.Width = 80;
        }

        // Add about dialog with student information 
        private void studentInformationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            String studentInfo = "Name: Tony Todorov\nFaculty number: 2001261067";
            String boxTitle = "Student Info";
            MessageBox.Show(studentInfo, boxTitle);
        }

        private bool IsPositiveNumber(String strNumber)
        {
            Regex objNotPositivePattern = new Regex("[^0-9.]");
            Regex objPositivePattern = new Regex("^[.][0-9]+$|[0-9]*[.]*[0-9]+$");
            Regex objTwoDotPattern = new Regex("[0-9]*[.][0-9]*[.][0-9]*");
            return !objNotPositivePattern.IsMatch(strNumber) &&
            objPositivePattern.IsMatch(strNumber) &&
            !objTwoDotPattern.IsMatch(strNumber);
        }

    }
}
