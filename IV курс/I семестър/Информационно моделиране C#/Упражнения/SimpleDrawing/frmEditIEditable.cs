using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace SimpleDrawing
{
    public partial class frmEditIEditable : Form
    {
        private List<Control> _controls;
        private IEditable _item;
        private frmMain _main;

        public frmEditIEditable(IEditable item, frmMain main)
        {
            InitializeComponent();

            _controls = new List<Control>();
            _item = item;
            _main = main;
            
            int height = 0;
            int panelHeight = 28;

            foreach (PropertyDescriptor editableProperty in _item.GetEditableProperties())
            {
                Panel pnl = new Panel();
                pnl.Parent = this;
                pnl.Dock = DockStyle.Top;
                pnl.Padding = new Padding(6);
                pnl.Height = panelHeight;

                Label lbl = new Label();
                lbl.Parent = pnl;
                lbl.AutoSize = false;
                lbl.Location = new Point(6, 6);
                lbl.TextAlign = ContentAlignment.MiddleLeft;
                lbl.Size = new Size(100, 21);
                lbl.Text = editableProperty.Caption;

                TextBox tb = new TextBox();
                tb.Parent = pnl;
                tb.Location = new Point(110, 6);
                tb.Width = 260;
                tb.Text = Convert.ToString(_item[editableProperty.Key]);
                tb.Tag = editableProperty;
                tb.Validating += new CancelEventHandler(tb_Validating);
                _controls.Add(tb);

                height += panelHeight;
            }
            height += panelHeight + 10;

            this.Width = 394;
            this.Height = height + this.pnlFooter.Height;
            if (item is IRenderable)
            {
                this.Text = "Edit: " + ((IRenderable)item).Name;
            }
            else
                this.Text = "";
        }

        private void tb_Validating(object sender, CancelEventArgs e)
        {
            if (sender is TextBox)
            {
                TextBox tb = (TextBox)sender;
                PropertyDescriptor editableProperty = (PropertyDescriptor)tb.Tag;

                if (editableProperty.Type.IsAssignableFrom(typeof(String)))
                {
                    e.Cancel = tb.Text == String.Empty;
                    if (e.Cancel)
                        errorProvider.SetError(tb, editableProperty.Caption + " is required");
                }
                else if (editableProperty.Type.IsAssignableFrom(typeof(Decimal)))
                {
                    Decimal test;
                    e.Cancel = !Decimal.TryParse(tb.Text, out test);
                    if (e.Cancel)
                        errorProvider.SetError(tb, editableProperty.Caption + " is not Decimal");
                }
            }
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            errorProvider.Clear();
            if (!this.ValidateChildren())
                return;

            foreach (Control ctrl in _controls)
            {
                if (ctrl is TextBox)
                {
                    TextBox tb = (TextBox)ctrl;
                    PropertyDescriptor editableProperty = (PropertyDescriptor)tb.Tag;

                    _item[editableProperty.Key] = tb.Text;
                }
            }

            DialogResult = DialogResult.OK;
            _main.Refresh();
        }


    }
}
