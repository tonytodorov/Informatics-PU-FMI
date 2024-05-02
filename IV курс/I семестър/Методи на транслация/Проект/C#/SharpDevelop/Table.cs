using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;

namespace scsc
{
	public class Table
	{
		private Stack<Dictionary<string, TableSymbol>> symbolTable;
		private Dictionary<string, TableSymbol> fieldScope;
		private Dictionary<string, TableSymbol> universeScope;
		private List<string> usingNamespaces = new List<string>();
		private List<string> references;
		
		public Table(List<string> references)
		{
			this.symbolTable = new Stack<Dictionary<string, TableSymbol>>();
			this.universeScope = BeginScope();
			this.fieldScope = BeginScope();
			this.references = references;
			foreach (string assemblyRef in references) {
				Assembly.LoadWithPartialName(assemblyRef);
				//Assembly.Load(assemblyRef);
			}
		}
		
		public override string ToString()
		{
			StringBuilder s = new StringBuilder();
			int i = symbolTable.Count;
			s.AppendFormat("=========\n");
			foreach (Dictionary<string, TableSymbol> table in symbolTable) {
				s.AppendFormat("---[{0}]---\n", i--);
				foreach (KeyValuePair<string, TableSymbol> row in table) {
					s.AppendFormat("[{0}] {1}\n", row.Key, row.Value);
				}
			}
			s.AppendFormat("=========\n");
			return s.ToString();
		}
		
		public void AddUsingNamespace(string usingNamespace)
		{
			usingNamespaces.Add(usingNamespace);
		}
		
		public TableSymbol Add(TableSymbol symbol) {
			symbolTable.Peek().Add(symbol.value, symbol);
			return symbol;
		}
		
		public TableSymbol AddToUniverse(TableSymbol symbol) {
			universeScope.Add(symbol.value, symbol);
			return symbol;
		}
		
		public FieldSymbol AddField(IdentToken token, FieldInfo field) {
			FieldSymbol result = new FieldSymbol(token, field);
			fieldScope.Add(token.value, result);
			return result;
		}
		
		public LocalVarSymbol AddLocalVar(IdentToken token, LocalBuilder localBuilder) {
			LocalVarSymbol result = new LocalVarSymbol(token, localBuilder);
			symbolTable.Peek().Add(token.value, result);
			return result;
		}
		
		public FormalParamSymbol AddFormalParam(IdentToken token, Type type, ParameterBuilder parameterInfo) {
			FormalParamSymbol result = new FormalParamSymbol(token, type, parameterInfo);
			symbolTable.Peek().Add(token.value, result);
			return result;
		}
		
		public MethodSymbol AddMethod(IdentToken token, Type type, FormalParamSymbol[] formalParams, MethodInfo methodInfo) {
			MethodSymbol result = new MethodSymbol(token, type, formalParams, methodInfo);
			symbolTable.Peek().Add(token.value, result);
			return result;
		}
		
		public Dictionary<string, TableSymbol> BeginScope()
		{
			symbolTable.Push(new Dictionary<string, TableSymbol>());
			return symbolTable.Peek();
		}
		
		public void EndScope()
		{
			Debug.WriteLine(ToString());
			
			symbolTable.Pop();
		}
		
		public TableSymbol GetSymbol(string ident)
		{
			TableSymbol result;
			foreach (Dictionary<string, TableSymbol> table in symbolTable) {
				if (table.TryGetValue(ident, out result)) {
					return result;
				}
			}
			return ResolveExternalMember(ident);
		}
		
		public bool ExistCurrentScopeSymbol(string ident)
		{
			return symbolTable.Peek().ContainsKey(ident);
		}
		
		public Type ResolveExternalType(string ident)
		{
			// Type
			// Namespace.Type
			
			Type type = Type.GetType(ident, false, false);
			if (type != null) return type;
			foreach (string ns in usingNamespaces) {
				string nsTypeName = ns + Type.Delimiter + ident;
				foreach (Assembly assembly in AppDomain.CurrentDomain.GetAssemblies()) {
					type = assembly.GetType(ident);
					if (type != null) return type;
					type = assembly.GetType(nsTypeName);
					if (type != null) return type;
				}
			}
			return null;
		}
			
		public TableSymbol ResolveExternalMember(string ident)
		{
			// Type.Member
			// Namespace.Type.Member
			
			int lastIx = ident.LastIndexOf(Type.Delimiter);
			if (lastIx > 0) {
				string memberName = ident.Substring(lastIx + 1);
				string typeName = ident.Substring(0, lastIx);
				Debug.WriteLine(string.Format("{0} -- {1}", typeName, memberName));
				
				Type type = ResolveExternalType(typeName);
				if (type == null) {
					foreach (string usingNamespace in usingNamespaces) {
						type = ResolveExternalType(usingNamespace + "." + typeName);
						if (type != null) break;
					}
				}
				
				if (type != null) {
					FieldInfo fi = type.GetField(memberName, BindingFlags.Public | BindingFlags.Static);
					if (fi != null) return new FieldSymbol(new IdentToken(0,0,memberName), fi);
					MemberInfo[] mi = type.GetMember(memberName, MemberTypes.Method, BindingFlags.Public | BindingFlags.Static);
					if (mi != null) return new ExternalMethodSymbol(new IdentToken(0,0,memberName), (MethodInfo[])mi);
				}
			}
			
			return null;
		}
		
	}
}
