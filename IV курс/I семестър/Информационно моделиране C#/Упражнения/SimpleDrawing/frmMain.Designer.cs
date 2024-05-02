namespace SimpleDrawing
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.dlgOpen = new System.Windows.Forms.OpenFileDialog();
            this.dlgSave = new System.Windows.Forms.SaveFileDialog();
            this.tsMenu = new System.Windows.Forms.ToolStrip();
            this.btnSelect = new System.Windows.Forms.ToolStripButton();
            this.btnCoefficient = new System.Windows.Forms.ToolStripButton();
            this.btnStock = new System.Windows.Forms.ToolStripButton();
            this.btnRefference = new System.Windows.Forms.ToolStripButton();
            this.btnFlow = new System.Windows.Forms.ToolStripButton();
            this.tsbResultTable = new System.Windows.Forms.ToolStripButton();
            this.tsbDiagram = new System.Windows.Forms.ToolStripButton();
            this.statusbar1 = new System.Windows.Forms.StatusStrip();
            this.sbLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.pbMenu = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.saveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.simulationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.runToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.studentInformationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dlgColour = new System.Windows.Forms.ColorDialog();
            this.pbDashboard = new System.Windows.Forms.PictureBox();
            this.tsMenu.SuspendLayout();
            this.statusbar1.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbDashboard)).BeginInit();
            this.SuspendLayout();
            // 
            // dlgOpen
            // 
            this.dlgOpen.DefaultExt = "*.mdl";
            this.dlgOpen.FileName = "openFileDialog1";
            this.dlgOpen.Filter = "Modeling files (*.mdl)|*.mdl|All files (*.*)|*.*";
            // 
            // dlgSave
            // 
            this.dlgSave.DefaultExt = "*.mdl";
            this.dlgSave.Filter = "Modeling files (*.mdl)|*.mdl|All files (*.*)|*.*";
            // 
            // tsMenu
            // 
            this.tsMenu.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tsMenu.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.tsMenu.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnSelect,
            this.btnCoefficient,
            this.btnStock,
            this.btnRefference,
            this.btnFlow,
            this.tsbResultTable,
            this.tsbDiagram});
            this.tsMenu.Location = new System.Drawing.Point(0, 28);
            this.tsMenu.Name = "tsMenu";
            this.tsMenu.Size = new System.Drawing.Size(740, 27);
            this.tsMenu.TabIndex = 5;
            this.tsMenu.Text = "toolStrip1";
            this.tsMenu.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.tsMenu_ItemClicked);
            // 
            // btnSelect
            // 
            this.btnSelect.AutoSize = false;
            this.btnSelect.AutoToolTip = false;
            this.btnSelect.BackColor = System.Drawing.SystemColors.Control;
            this.btnSelect.Image = global::SimpleDrawing.Properties.Resources._005_select;
            this.btnSelect.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnSelect.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnSelect.Name = "btnSelect";
            this.btnSelect.Size = new System.Drawing.Size(80, 22);
            this.btnSelect.Text = "Select";
            this.btnSelect.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnSelect.ToolTipText = "Select";
            // 
            // btnCoefficient
            // 
            this.btnCoefficient.Image = global::SimpleDrawing.Properties.Resources._001_coeff;
            this.btnCoefficient.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnCoefficient.Name = "btnCoefficient";
            this.btnCoefficient.Size = new System.Drawing.Size(99, 24);
            this.btnCoefficient.Text = "Coefficient";
            // 
            // btnStock
            // 
            this.btnStock.AutoSize = false;
            this.btnStock.Image = global::SimpleDrawing.Properties.Resources._001_stock;
            this.btnStock.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnStock.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnStock.Name = "btnStock";
            this.btnStock.Size = new System.Drawing.Size(60, 22);
            this.btnStock.Text = "Stock";
            // 
            // btnRefference
            // 
            this.btnRefference.Image = global::SimpleDrawing.Properties.Resources._001_reference;
            this.btnRefference.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnRefference.Name = "btnRefference";
            this.btnRefference.Size = new System.Drawing.Size(103, 24);
            this.btnRefference.Text = "Refference";
            // 
            // btnFlow
            // 
            this.btnFlow.Image = global::SimpleDrawing.Properties.Resources._001_flow;
            this.btnFlow.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.btnFlow.Name = "btnFlow";
            this.btnFlow.Size = new System.Drawing.Size(60, 24);
            this.btnFlow.Text = "Flow";
            // 
            // tsbResultTable
            // 
            this.tsbResultTable.Image = global::SimpleDrawing.Properties.Resources._001_resulttable;
            this.tsbResultTable.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbResultTable.Name = "tsbResultTable";
            this.tsbResultTable.Size = new System.Drawing.Size(112, 24);
            this.tsbResultTable.Text = "Result Table";
            // 
            // tsbDiagram
            // 
            this.tsbDiagram.Image = global::SimpleDrawing.Properties.Resources._001_diagram;
            this.tsbDiagram.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tsbDiagram.Name = "tsbDiagram";
            this.tsbDiagram.Size = new System.Drawing.Size(86, 24);
            this.tsbDiagram.Text = "Diagram";
            // 
            // statusbar1
            // 
            this.statusbar1.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.statusbar1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.statusbar1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sbLabel1});
            this.statusbar1.Location = new System.Drawing.Point(0, 436);
            this.statusbar1.Name = "statusbar1";
            this.statusbar1.Size = new System.Drawing.Size(740, 22);
            this.statusbar1.TabIndex = 6;
            this.statusbar1.Text = "statusStrip1";
            // 
            // sbLabel1
            // 
            this.sbLabel1.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.sbLabel1.Name = "sbLabel1";
            this.sbLabel1.Size = new System.Drawing.Size(0, 16);
            // 
            // pbMenu
            // 
            this.pbMenu.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.pbMenu.Name = "pbMenu";
            this.pbMenu.Size = new System.Drawing.Size(61, 4);
            // 
            // menuStrip1
            // 
            this.menuStrip1.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.simulationToolStripMenuItem,
            this.aboutToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(740, 28);
            this.menuStrip1.TabIndex = 8;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newToolStripMenuItem,
            this.openToolStripMenuItem,
            this.toolStripSeparator,
            this.saveToolStripMenuItem,
            this.toolStripSeparator2,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(42, 24);
            this.fileToolStripMenuItem.Text = "&File";
            // 
            // newToolStripMenuItem
            // 
            this.newToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("newToolStripMenuItem.Image")));
            this.newToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.newToolStripMenuItem.Name = "newToolStripMenuItem";
            this.newToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.N)));
            this.newToolStripMenuItem.Size = new System.Drawing.Size(191, 26);
            this.newToolStripMenuItem.Text = "&New";
            this.newToolStripMenuItem.Click += new System.EventHandler(this.newToolStripButton_Click);
            // 
            // openToolStripMenuItem
            // 
            this.openToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("openToolStripMenuItem.Image")));
            this.openToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.openToolStripMenuItem.Name = "openToolStripMenuItem";
            this.openToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.O)));
            this.openToolStripMenuItem.Size = new System.Drawing.Size(191, 26);
            this.openToolStripMenuItem.Text = "&Open";
            this.openToolStripMenuItem.Click += new System.EventHandler(this.openToolStripButton_Click);
            // 
            // toolStripSeparator
            // 
            this.toolStripSeparator.Name = "toolStripSeparator";
            this.toolStripSeparator.Size = new System.Drawing.Size(188, 6);
            // 
            // saveToolStripMenuItem
            // 
            this.saveToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("saveToolStripMenuItem.Image")));
            this.saveToolStripMenuItem.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.saveToolStripMenuItem.Name = "saveToolStripMenuItem";
            this.saveToolStripMenuItem.ShortcutKeys = ((System.Windows.Forms.Keys)((System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.S)));
            this.saveToolStripMenuItem.Size = new System.Drawing.Size(191, 26);
            this.saveToolStripMenuItem.Text = "&Save As";
            this.saveToolStripMenuItem.Click += new System.EventHandler(this.saveToolStripButton_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(188, 6);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(191, 26);
            this.exitToolStripMenuItem.Text = "E&xit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // simulationToolStripMenuItem
            // 
            this.simulationToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.runToolStripMenuItem});
            this.simulationToolStripMenuItem.Name = "simulationToolStripMenuItem";
            this.simulationToolStripMenuItem.Size = new System.Drawing.Size(86, 24);
            this.simulationToolStripMenuItem.Text = "Simulation";
            // 
            // runToolStripMenuItem
            // 
            this.runToolStripMenuItem.Image = global::SimpleDrawing.Properties.Resources._003_runer_silhouette_running_fast;
            this.runToolStripMenuItem.Name = "runToolStripMenuItem";
            this.runToolStripMenuItem.Size = new System.Drawing.Size(115, 26);
            this.runToolStripMenuItem.Text = "Run";
            this.runToolStripMenuItem.Click += new System.EventHandler(this.runToolStripMenuItem_Click);
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.studentInformationToolStripMenuItem});
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(60, 24);
            this.aboutToolStripMenuItem.Text = "About";
            // 
            // studentInformationToolStripMenuItem
            // 
            this.studentInformationToolStripMenuItem.Name = "studentInformationToolStripMenuItem";
            this.studentInformationToolStripMenuItem.Size = new System.Drawing.Size(224, 26);
            this.studentInformationToolStripMenuItem.Text = "Student Information";
            this.studentInformationToolStripMenuItem.Click += new System.EventHandler(this.studentInformationToolStripMenuItem_Click);
            // 
            // pbDashboard
            // 
            this.pbDashboard.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pbDashboard.Location = new System.Drawing.Point(0, 55);
            this.pbDashboard.Name = "pbDashboard";
            this.pbDashboard.Padding = new System.Windows.Forms.Padding(0, 60, 0, 0);
            this.pbDashboard.Size = new System.Drawing.Size(740, 381);
            this.pbDashboard.TabIndex = 0;
            this.pbDashboard.TabStop = false;
            this.pbDashboard.Click += new System.EventHandler(this.pbDashboard_Click);
            this.pbDashboard.Paint += new System.Windows.Forms.PaintEventHandler(this.pbDashboard_Paint);
            this.pbDashboard.DoubleClick += new System.EventHandler(this.pbDashboard_DoubleClick);
            this.pbDashboard.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pbDashboard_MouseDown);
            this.pbDashboard.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pbDashboard_MouseMove);
            this.pbDashboard.MouseUp += new System.Windows.Forms.MouseEventHandler(this.pbDashboard_MouseUp);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(740, 458);
            this.Controls.Add(this.pbDashboard);
            this.Controls.Add(this.tsMenu);
            this.Controls.Add(this.statusbar1);
            this.Controls.Add(this.menuStrip1);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.KeyPreview = true;
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Tag = "Select";
            this.Text = "Stella v0.0.1";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.frmMain_KeyDown);
            this.tsMenu.ResumeLayout(false);
            this.tsMenu.PerformLayout();
            this.statusbar1.ResumeLayout(false);
            this.statusbar1.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbDashboard)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox pbDashboard;
        private System.Windows.Forms.OpenFileDialog dlgOpen;
        private System.Windows.Forms.SaveFileDialog dlgSave;
        private System.Windows.Forms.ToolStrip tsMenu;
        private System.Windows.Forms.ToolStripButton btnSelect;
        private System.Windows.Forms.ToolStripButton btnCoefficient;
        private System.Windows.Forms.ToolStripButton btnStock;
        private System.Windows.Forms.ToolStripButton btnRefference;
        private System.Windows.Forms.ToolStripButton btnFlow;
        private System.Windows.Forms.ToolStripButton tsbResultTable;
        private System.Windows.Forms.ToolStripButton tsbDiagram;
        private System.Windows.Forms.StatusStrip statusbar1;
        private System.Windows.Forms.ToolStripStatusLabel sbLabel1;
        private System.Windows.Forms.ContextMenuStrip pbMenu;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem openToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator;
        private System.Windows.Forms.ToolStripMenuItem saveToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem simulationToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem runToolStripMenuItem;
        private System.Windows.Forms.ColorDialog dlgColour;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem studentInformationToolStripMenuItem;
    }
}

