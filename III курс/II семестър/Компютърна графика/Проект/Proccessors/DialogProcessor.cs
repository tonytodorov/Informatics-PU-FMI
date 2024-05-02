using System;
using System.Collections.Generic;
using System.Drawing;
using System.Reflection;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TreeView;

namespace Draw
{
	/// <summary>
	/// Класът, който ще бъде използван при управляване на диалога.
	/// </summary>
	public class DialogProcessor : DisplayProcessor
	{
		#region Constructor
		
		public DialogProcessor()
		{
		}
		
		#endregion
		
		#region Properties
		
		/// <summary>
		/// Избран елемент.
		/// </summary>
		private Shape selection;
        public Shape Selection {
			get { return selection; }
			set { selection = value; }
		}
		
		/// <summary>
		/// Дали в момента диалога е в състояние на "влачене" на избрания елемент.
		/// </summary>
		private bool isDragging;
		public bool IsDragging {
			get { return isDragging; }
			set { isDragging = value; }
		}
		
		/// <summary>
		/// Последна позиция на мишката при "влачене".
		/// Използва се за определяне на вектора на транслация.
		/// </summary>
		private PointF lastLocation;
		public PointF LastLocation {
			get { return lastLocation; }
			set { lastLocation = value; }
		}
		
		#endregion
		
		/// <summary>
		/// Добавя примитив - правоъгълник на произволно място върху клиентската област.
		/// </summary>
		public void AddRandomRectangle()
		{
			Random rnd = new Random();
			int x = rnd.Next(100,1000);
			int y = rnd.Next(100,600);
			
			RectangleShape rect = new RectangleShape(new Rectangle(x,y,100,200));
			rect.FillColor = Color.White;

			ShapeList.Add(rect);
		}

        public void AddRandomEllipse(int strokeWidth)
        {
            Random rnd = new Random();
            int x = rnd.Next(100, 1000);
            int y = rnd.Next(100, 600);

            EllipseShape ellipse = new EllipseShape(new Rectangle(x, y, 100, 200));
            ellipse.FillColor = Color.White;
			ellipse.StrokeWidth = strokeWidth;

            ShapeList.Add(ellipse);
        }

        public void AddRandomPolygon()
        {
            Random rnd = new Random();
            int x = rnd.Next(100, 1000);
            int y = rnd.Next(100, 600);

            DrawLine polygon = new DrawLine(new Rectangle(x, y, 100, 200));
            polygon.FillColor = Color.White;
            polygon.StrokeColor = Color.Green;

            ShapeList.Add(polygon);
        }

        /// <summary>
        /// Проверява дали дадена точка е в елемента.
        /// Обхожда в ред обратен на визуализацията с цел намиране на
        /// "най-горния" елемент т.е. този който виждаме под мишката.
        /// </summary>
        /// <param name="point">Указана точка</param>
        /// <returns>Елемента на изображението, на който принадлежи дадената точка.</returns>
        public Shape ContainsPoint(PointF point)
		{
			for(int i = ShapeList.Count - 1; i >= 0; i--){
				if (ShapeList[i].Contains(point)){
					ShapeList[i].FillColor = Color.Green;
						
					return ShapeList[i];
				}	
			}
			return null;
		}
		
		/// <summary>
		/// Транслация на избраният елемент на вектор определен от <paramref name="p>p</paramref>
		/// </summary>
		/// <param name="p">Вектор на транслация.</param>
		public void TranslateTo(PointF p)
		{
			if (selection != null)
			{
				selection.Location = new PointF(selection.Location.X + p.X - lastLocation.X, selection.Location.Y + p.Y - lastLocation.Y);
                lastLocation = p;
            }
		}

		public void SetStrokeColor(Color color)
		{
			if(Selection != null)
			{
				Selection.StrokeColor = color;
			}
		}

        public void SetOpacity(int opacity)
        {
            if (Selection != null)
            {
                Selection.Opacity = opacity;
            }
        }

        public void SetFillColor(Color color)
        {
            if (Selection != null)
            {
                Selection.FillColor = color;
            }
        }

        public void RotatePrimitive(int angle)
        {
            if (Selection != null)
            {
                Selection.TransformationMatrix.RotateAt(angle, new PointF(
					Selection.Location.X + Selection.Width / 2, 
					Selection.Location.Y + Selection.Height / 2));
            }
        }

        public override void Draw(Graphics grfx)
        {
            base.Draw(grfx);

            float[] dashValues = { 4, 2 };
            Pen dashPen = new Pen(Color.Black, 3);
            dashPen.DashPattern = dashValues;


            if (selection != null)
			{
				grfx.DrawRectangle(
                    dashPen,
					Selection.Location.X - 3,
					Selection.Location.Y - 3,
					Selection.Width + 3,
					Selection.Height + 6
					);
			}
        }
    }
}
