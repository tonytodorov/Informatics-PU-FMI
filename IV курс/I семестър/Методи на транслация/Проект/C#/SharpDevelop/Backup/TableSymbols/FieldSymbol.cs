using System;
using System.Reflection;
using System.Text;

namespace scsc
{
	public class FieldSymbol: TableSymbol 
	{
		public FieldInfo fieldInfo;
		
		public FieldSymbol(IdentToken token, FieldInfo fieldInfo): base(token.line, token.column, token.value)
		{
			this.fieldInfo = fieldInfo;
		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			s.AppendFormat("line {0}, column {1}: {2} - {3} fieldtype={4}", line, column, value, GetType(), fieldInfo.FieldType);
			return s.ToString();
		}
	}
}
