using System;
using System.Reflection.Emit;
using System.Text;

namespace scsc
{
	public class FormalParamSymbol: TableSymbol
	{
		public Type paramType;
		public ParameterBuilder parameterInfo;
		
		public FormalParamSymbol(IdentToken token, Type paramType, ParameterBuilder parameterInfo): base(token.line, token.column, token.value)
		{
			this.paramType = paramType;
			this.parameterInfo = parameterInfo;
		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			s.AppendFormat("line {0}, column {1}: {2} - {3} formalparamtype={4}", line, column, value, GetType(), paramType);
			return s.ToString();
		}
	}
}
