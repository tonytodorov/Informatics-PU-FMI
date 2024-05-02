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
    public partial class frmDiagram : Form
    {
        Diagram item;

        public frmDiagram(Diagram source)
        {
            item = (Diagram)source.Clone();
            InitializeComponent();
            item.SetRectangle(new Rectangle(0, 0, pbGraphic.Width, pbGraphic.Height));
        }

        private void pbGraphic_Paint(object sender, PaintEventArgs e)
        {
            item.Draw(sender, e.Graphics);
        }

        private void frmDiagram_Resize(object sender, EventArgs e)
        {
            item.SetRectangle(new Rectangle(0, 0, pbGraphic.Width, pbGraphic.Height));
            pbGraphic.Refresh();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void saveAsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (pbSaveDlg.ShowDialog(this) == DialogResult.OK)
            {
                Bitmap img = new Bitmap(pbGraphic.Width, pbGraphic.Height, pbGraphic.CreateGraphics());
                using (Graphics g = Graphics.FromImage(img))
                {
                    item.Draw(sender, g);
                }
                img.Save(pbSaveDlg.FileName, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
        }
    }
}
