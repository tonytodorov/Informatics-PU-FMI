using System;
using System.Reflection;
using System.Text;

namespace scsc
{
	public class MethodSymbol: TableSymbol
	{
		public Type returnType;
		public FormalParamSymbol[] formalParams;
		public MethodInfo methodInfo;
		
		public MethodSymbol(IdentToken token, Type returnType, FormalParamSymbol[] formalParams, MethodInfo methodInfo): base(token.line, token.column, token.value)
		{
			this.returnType = returnType;
			this.formalParams = formalParams;
			this.methodInfo = methodInfo;
		}
		
//		public Type[] GetParamTypes()
//		{
//			Type[] paramTypes = new Type[formalParams.Length];
//			for (int i=0; i<formalParams.Length; i++) {
//				paramTypes[i] = formalParams[i].paramType;
//			}
//			return paramTypes;
//		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			s.AppendFormat("line {0}, column {1}: {2} - {3} methodsignature={4} {5}(", line, column, value, GetType(), returnType, value);
			foreach (FormalParamSymbol param in formalParams) {
				s.AppendFormat("{0} {1}, ", param.paramType, param.value);
			}
			if (formalParams.Length != 0) s.Remove(s.Length-2, 2);
			s.Append(")");
			return s.ToString();
		}
	}
}
