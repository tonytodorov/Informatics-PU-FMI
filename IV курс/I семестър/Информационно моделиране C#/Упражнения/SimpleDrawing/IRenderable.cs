using System;

namespace SimpleDrawing
{
	public interface IRenderable
	{
        string Name { get; }
        string Render();
        string GetVariables();
        string GetHint();
	}
}
