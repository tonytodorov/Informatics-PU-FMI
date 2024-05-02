using System;
using System.Text;

namespace scsc
{
	public abstract class TypeSymbol: TableSymbol
	{
		public Type type;
		
		public TypeSymbol(IdentToken token, Type type): base(token.line, token.column, token.value)
		{
			this.type = type;
		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			s.AppendFormat("line {0}, column {1}: {2} - {3} type={4}", line, column, value, GetType(), type.FullName);
			return s.ToString();
		}
	}
}
