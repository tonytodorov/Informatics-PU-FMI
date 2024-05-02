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
    public partial class frmRun : Form
    {
        DummyObj obj;

        public frmRun(DummyObj obj)
        {
            this.obj = obj;
            InitializeComponent();
        }    

        private void btnOk_Click(object sender, EventArgs e)
        {
            obj.Step = System.Convert.ToDouble(tbStep.Text);
            obj.Iteration = Convert.ToInt32(tbIteration.Text);
        }

        
    }
}
