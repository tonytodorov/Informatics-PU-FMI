using Draw;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System;

[Serializable]
public class ShapesList : List<Shape>
{
    public void Save(string file)
    {
        using (Stream stream = File.Open(file, FileMode.Create))
        {
            BinaryFormatter bin = new BinaryFormatter();
            bin.Serialize(stream, this);
        }
    }
    public void Load(string file)
    {
        using (Stream stream = File.Open(file, FileMode.Open))
        {
            BinaryFormatter bin = new BinaryFormatter();
            var shapes = (ShapesList)bin.Deserialize(stream);
            this.Clear();
            this.AddRange(shapes);
        }
    }
    public void Draw(Graphics g)
    {
        this.ForEach(x => x.DrawSelf(g));
    }
}