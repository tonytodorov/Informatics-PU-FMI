using System;
using System.Reflection;
using System.Text;

namespace scsc
{
	public class LocalVarSymbol: TableSymbol
	{
		public LocalVariableInfo localVariableInfo;
		
		public LocalVarSymbol(IdentToken token, LocalVariableInfo localVariableInfo): base(token.line, token.column, token.value)
		{
			this.localVariableInfo = localVariableInfo;
		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			s.AppendFormat("line {0}, column {1}: {2} - {3} localvartype={4} localindex={5}", line, column, value, GetType(), localVariableInfo.LocalType, localVariableInfo.LocalIndex);
			return s.ToString();
		}
	}
}
