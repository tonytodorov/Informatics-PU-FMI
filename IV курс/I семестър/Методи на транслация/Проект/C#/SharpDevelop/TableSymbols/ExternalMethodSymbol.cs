using System;
using System.Reflection;
using System.Text;

namespace scsc
{
	public class ExternalMethodSymbol: TableSymbol
	{
		public MethodInfo[] methodInfo;
		
		public ExternalMethodSymbol(IdentToken token, MethodInfo[] methodInfo): base(token.line, token.column, token.value)
		{
			this.methodInfo = methodInfo;
		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			s.AppendFormat("line {0}, column {1}: {2} - {3} methodsignatures:", line, column, value, GetType());
			foreach (MethodInfo mi in methodInfo) {
				s.AppendFormat("\t{0} {1}(", mi.ReturnType.FullName, mi.Name);
				foreach (ParameterInfo pi in mi.GetParameters()) {
					s.AppendFormat("{0},", pi.ParameterType.FullName);
				}
				if (mi.GetParameters().Length != 0) s.Remove(s.Length-2, 2);
				s.Append(")\n");
			}
			s.Remove(s.Length-1, 1);
			return s.ToString();
		}
	}
}
