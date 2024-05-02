using System.Windows.Forms;

namespace SimpleDrawing
{
    interface IResizable
    {
        bool Resize(int x, int y, int Index);
        Cursor GetCursor(int Index);
    }
}
