using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;

namespace scsc
{
	public class Emit
	{
		private AssemblyBuilder assembly;
		private ModuleBuilder module;
		private TypeBuilder program;
		private MethodBuilder method;
		private ConstructorBuilder cctor;
		private ILGenerator il;
		private ILGenerator il_cctor;
		private string executableName;
		private Table symbolTable;
		private bool isMain;
		private bool haveMainMethod;
		
		public Emit(string name, Table symbolTable)
		{
			this.symbolTable = symbolTable;
			executableName = name;
			AssemblyName assemblyName = new AssemblyName();
			assemblyName.Name = Path.GetFileNameWithoutExtension(name);
			string dir = Path.GetDirectoryName(name);
			
			string moduleName = Path.GetFileName(name);
			
			assembly = AppDomain.CurrentDomain.DefineDynamicAssembly(assemblyName, AssemblyBuilderAccess.Save, dir);
			module = assembly.DefineDynamicModule(assemblyName + "Module", moduleName);
			haveMainMethod = false;
		}
		
		public TypeBuilder InitProgramClass(string programName)
		{
			program = module.DefineType(programName, TypeAttributes.Class | TypeAttributes.Public);
			cctor = program.DefineConstructor(MethodAttributes.Static | MethodAttributes.Public, CallingConventions.Standard, Type.EmptyTypes);
			il_cctor = cctor.GetILGenerator();
			il_cctor.BeginScope();
			
			return program;
		}
		
		public void WriteExecutable()
		{
			FinishLastMethod();
			if (!haveMainMethod) {
				method = program.DefineMethod("main", MethodAttributes.Static | MethodAttributes.Public, typeof(int), Type.EmptyTypes);
				il = method.GetILGenerator();
				il.Emit(OpCodes.Ldc_I4_0);
				il.Emit(OpCodes.Ret);
				assembly.SetEntryPoint(method);
			}
			
			il_cctor.Emit(OpCodes.Ret);
			il_cctor.EndScope();
			
			program.CreateType();
			assembly.Save(Path.GetFileName(executableName));
		}
		
		public FieldInfo AddField(string fieldName, Type type, long arraySize)
		{
			FieldInfo field = program.DefineField(fieldName, type, FieldAttributes.Public | FieldAttributes.Static);
			if (type.IsArray) {
				il_cctor.Emit(OpCodes.Ldc_I4, arraySize);
				il_cctor.Emit(OpCodes.Newarr, type.GetElementType());
				il_cctor.Emit(OpCodes.Stsfld, field);
			} else if (CanInitializeLocation(type)) {
				il_cctor.Emit(OpCodes.Stsfld, field);
			}
			return field;
		}
		
		public ParameterBuilder AddParam(string paramName, int paramIndex, Type type)
		{
			ParameterBuilder param = method.DefineParameter(paramIndex, ParameterAttributes.None, paramName);
			return param;
		}
		
		public void AddConditionOp(string op)
		{
			switch (op) {
				case "<":
					il.Emit(OpCodes.Clt);
					break;
				case "<=":
					il.Emit(OpCodes.Cgt);
					il.Emit(OpCodes.Ldc_I4_0);
					il.Emit(OpCodes.Ceq);
					break;
				case ">":
					il.Emit(OpCodes.Cgt);
					break;
				case ">=":
					il.Emit(OpCodes.Clt);
					il.Emit(OpCodes.Ldc_I4_0);
					il.Emit(OpCodes.Ceq);
					break;
				case "==":
					il.Emit(OpCodes.Ceq);
					break;
				case "!=":
					il.Emit(OpCodes.Ceq);
					il.Emit(OpCodes.Ldc_I4_0);
					il.Emit(OpCodes.Ceq);
					break;
			}
		}
		
		public void AddAsOp(Type type, Type type1)
		{
			if (type.IsValueType)
				il.Emit(OpCodes.Box, type);
			else
				il.Emit(OpCodes.Isinst, type1);
		}
		
		public void AddCast(Type castType, Type exprType)
		{
			if (!castType.IsValueType && !exprType.IsValueType)
				il.Emit(OpCodes.Castclass, castType);
			else if (!castType.IsValueType && exprType.IsValueType)
				il.Emit(OpCodes.Box, exprType);
			else if (castType.IsValueType && !exprType.IsValueType)
				il.Emit(OpCodes.Unbox_Any, castType);
			else {
				if (castType==typeof(System.Single) && exprType==typeof(System.UInt32))
					il.Emit(OpCodes.Conv_R_Un);
				else if (castType==typeof(System.SByte)) // && exprType==typeof(System.Int32))
					il.Emit(OpCodes.Conv_I1);
				else if (castType==typeof(System.Int16))
					il.Emit(OpCodes.Conv_I2);
				else if (castType==typeof(System.Int16))
					il.Emit(OpCodes.Conv_I2);
				else if (castType==typeof(System.Int32))
					il.Emit(OpCodes.Conv_I4);
				else if (castType==typeof(System.Int64))
					il.Emit(OpCodes.Conv_I8);
				else if (castType==typeof(System.Single))
					il.Emit(OpCodes.Conv_R4);
				else if (castType==typeof(System.Double))
					il.Emit(OpCodes.Conv_R8);
				else if (castType==typeof(System.Byte))
					il.Emit(OpCodes.Conv_U1);
				else if (castType==typeof(System.UInt16))
					il.Emit(OpCodes.Conv_U2);
				else if (castType==typeof(System.UInt32))
					il.Emit(OpCodes.Conv_U4);
				else if (castType==typeof(System.UInt64))
					il.Emit(OpCodes.Conv_U8);
			}
		}
		
		public void AddIsOp(Type type)
		{
			il.Emit(OpCodes.Isinst, type);
			il.Emit(OpCodes.Ldnull);
			il.Emit(OpCodes.Cgt_Un);
		}
		
		public void AddBox(Type type)
		{
			il.Emit(OpCodes.Box, type);
		}
		
		public void AddUnboxAny(Type type)
		{
			il.Emit(OpCodes.Unbox_Any, type);
		}
		
		public void AddAssignCast(Type targetType, Type exprType)
		{
			if (!targetType.IsValueType && exprType.IsValueType)
				il.Emit(OpCodes.Box, exprType);
			else if (targetType.IsValueType && !exprType.IsValueType)
				il.Emit(OpCodes.Unbox_Any, targetType);
			//else ;
		}
		
		public void AddAdditiveOp(string op)
		{
			switch (op) {
				case "+":
					il.Emit(OpCodes.Add);
					break;
				case "-":
					il.Emit(OpCodes.Sub);
					break;
				case "|":
					il.Emit(OpCodes.Or);
					break;
				case "||":
					il.Emit(OpCodes.Or);
					break;
				case "^":
					il.Emit(OpCodes.Xor);
					break;
			}
		}
		
		private static MethodInfo concatMethodInfo = typeof(String).GetMethod("Concat", new Type[] {typeof(object),typeof(object)});
		public void AddConcatinationOp()
		{
			il.Emit(OpCodes.Call, concatMethodInfo);
		}
		
		
		public void AddMultiplicativeOp(string op)
		{
			switch (op) {
				case "*":
					il.Emit(OpCodes.Mul);
					break;
				case "/":
					il.Emit(OpCodes.Div);
					break;
				case "%":
					il.Emit(OpCodes.Rem);
					break;
				case "&":
					il.Emit(OpCodes.And);
					break;
				case "&&":
					il.Emit(OpCodes.And);
					break;
			}
		}
		
		public void AddUnaryOp(string op)
		{
			switch (op) {
				case "-":
					il.Emit(OpCodes.Neg);
					break;
				case "!":
					il.Emit(OpCodes.Not);
					break;
				case "~":
					il.Emit(OpCodes.Not);
					break;
			}
		}
		
		public MethodInfo AddMethod(string methodName, Type returnType, Type[] parameterTypes)
		{
			FinishLastMethod();
			
			method = program.DefineMethod(methodName, MethodAttributes.Public | MethodAttributes.Static, returnType, parameterTypes);
			method.InitLocals = true;
			il = method.GetILGenerator();
			
			BeginScope();

			isMain = false;
			if (methodName.ToLower() == "main") {
				if (returnType == typeof(Int32) && parameterTypes.Length == 0) {
					isMain = true;
					haveMainMethod = true;
					assembly.SetEntryPoint(method);
				}
			}
			
			return method;
		}
		
		public Type GetMethodReturnType()
		{
			return method.ReturnType;
		}
		
		public void AddMethodCall(MethodInfo methodInfo)
		{
			il.Emit(OpCodes.Call, methodInfo);
		}
		
		public void AddPop()
		{
			il.Emit(OpCodes.Pop);
		}
		
		public void BeginScope()
		{
			il.BeginScope();
		}
		
		public void EndScope()
		{
			il.EndScope();
		}
		
		public LocalBuilder AddLocalVar(string localVarName, Type localVarType)
		{
			LocalBuilder result = il.DeclareLocal(localVarType);
			if (CanInitializeLocation(localVarType)) {
				// Store the already prepared initializer
				il.Emit(OpCodes.Stloc, result);
			}
			return result;
		}
		
		private bool CanInitializeLocation(Type Ty) {
			if (!Ty.IsValueType) {
            	if (Ty == typeof(String)) {
                	il.Emit(OpCodes.Ldstr, "");
               	}
                else {
                	ConstructorInfo cons = Ty.GetConstructor(Type.EmptyTypes);
                    if (cons != null && !Ty.IsAbstract) {
                    	il.Emit(OpCodes.Newobj, Ty);
                    }
                    else {
                      il.Emit(OpCodes.Ldnull);
                    }
                }
                return true;
			}
			
			return false;
		}
				
		public void FinishLastMethod()
		{
			if (method == null) return;
			
			if (isMain) {
				il.Emit(OpCodes.Ldc_I4_0);
			}
			
			il.Emit(OpCodes.Ret);
			
			EndScope();
		}
		
		public void AddFieldAssigment(FieldInfo fieldInfo)
		{
			il.Emit(OpCodes.Stsfld, fieldInfo);
		}
		
		public void AddLoadArray(FieldInfo fieldInfo)
		{
			il.Emit(OpCodes.Ldsfld, fieldInfo);
		}
		
		public void AddArrayAssigment(FieldInfo fieldInfo)
		{
			il.Emit(OpCodes.Stelem, fieldInfo.FieldType.GetElementType());
		}
		
		public void AddLocalVarAssigment(LocalVariableInfo localVariableInfo)
		{
			il.Emit(OpCodes.Stloc, (LocalBuilder)localVariableInfo);
		}
		
		public void AddParameterAssigment(ParameterBuilder parameterInfo)
		{
			il.Emit(OpCodes.Starg, parameterInfo.Position-1);
		}
		
		public Label GetLabel()
		{
			return il.DefineLabel();
		}
		
		public void MarkLabel(Label label)
		{
			il.MarkLabel(label);
		}
		
		public void AddCondBranch(Label label)
		{
			il.Emit(OpCodes.Brfalse, label);
		}
		
		public void AddBranch(Label label)
		{
			il.Emit(OpCodes.Br, label);
		}
		
		public void AddReturn()
		{
			il.Emit(OpCodes.Ret);
		}
		
		public void AddGetField(FieldInfo fieldInfo)
		{
			il.Emit(OpCodes.Ldsfld, fieldInfo);
		}
		
		public void AddIncField(FieldInfo fieldInfo, Parser.IncDecOps incOp)
		{
			switch (incOp) {
				case Parser.IncDecOps.PostInc:
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Stsfld, fieldInfo);
					break;
				case Parser.IncDecOps.PostDec:
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Stsfld, fieldInfo);
					break;
				case Parser.IncDecOps.PreInc:
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Stsfld, fieldInfo);
					break;
				case Parser.IncDecOps.PreDec:
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Stsfld, fieldInfo);
					break;
			}
		}
		
		public void AddGetArray(FieldInfo fieldInfo)
		{
			il.Emit(OpCodes.Ldelem, fieldInfo.FieldType.GetElementType());
		}
		
		public void AddIncArray(FieldInfo fieldInfo, Parser.IncDecOps incOp)
		{
			LocalBuilder tempLocal;
			Type elemType;
			
			switch (incOp) {
				case Parser.IncDecOps.PostInc:
					elemType = fieldInfo.FieldType.GetElementType();
					il.Emit(OpCodes.Ldelema, elemType);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldobj, elemType);
					il.Emit(OpCodes.Dup);
					tempLocal = il.DeclareLocal(elemType);
					il.Emit(OpCodes.Stloc, tempLocal);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Stobj, elemType);
					il.Emit(OpCodes.Ldloc, tempLocal);
					break;
				case Parser.IncDecOps.PostDec:
					elemType = fieldInfo.FieldType.GetElementType();
					il.Emit(OpCodes.Ldelema, elemType);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldobj, elemType);
					il.Emit(OpCodes.Dup);
					tempLocal = il.DeclareLocal(elemType);
					il.Emit(OpCodes.Stloc, tempLocal);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Stobj, elemType);
					il.Emit(OpCodes.Ldloc, tempLocal);
					break;
				case Parser.IncDecOps.PreInc:
					elemType = fieldInfo.FieldType.GetElementType();
					il.Emit(OpCodes.Ldelema, elemType);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldobj, elemType);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Dup);
					tempLocal = il.DeclareLocal(elemType);
					il.Emit(OpCodes.Stloc, tempLocal);
					il.Emit(OpCodes.Stobj, elemType);
					il.Emit(OpCodes.Ldloc, tempLocal);
					break;
				case Parser.IncDecOps.PreDec:
					elemType = fieldInfo.FieldType.GetElementType();
					il.Emit(OpCodes.Ldelema, elemType);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldobj, elemType);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Dup);
					tempLocal = il.DeclareLocal(elemType);
					il.Emit(OpCodes.Stloc, tempLocal);
					il.Emit(OpCodes.Stobj, elemType);
					il.Emit(OpCodes.Ldloc, tempLocal);
					break;
			}
		}
		
		public void AddGetLocalVar(LocalVariableInfo localVariableInfo)
		{
			il.Emit(OpCodes.Ldloc, (LocalBuilder)localVariableInfo);
		}
		
		public void AddIncLocalVar(LocalVariableInfo localVariableInfo, Parser.IncDecOps incOp)
		{
			switch (incOp) {
				case Parser.IncDecOps.PostInc:
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Stloc, (LocalBuilder)localVariableInfo);
					break;
				case Parser.IncDecOps.PostDec:
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Stloc, (LocalBuilder)localVariableInfo);
					break;
				case Parser.IncDecOps.PreInc:
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Stloc, (LocalBuilder)localVariableInfo);
					break;
				case Parser.IncDecOps.PreDec:
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Stloc, (LocalBuilder)localVariableInfo);
					break;
			}
		}
		
		public void AddGetParameter(ParameterBuilder parameterInfo)
		{
			il.Emit(OpCodes.Ldarg, parameterInfo.Position-1);
		}
		
		public void AddIncParameter(ParameterBuilder parameterInfo, Parser.IncDecOps incOp)
		{
			switch (incOp) {
				case Parser.IncDecOps.PostInc:
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Starg, parameterInfo.Position-1);
					break;
				case Parser.IncDecOps.PostDec:
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Starg, parameterInfo.Position-1);
					break;
				case Parser.IncDecOps.PreInc:
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Add);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Starg, parameterInfo.Position-1);
					break;
				case Parser.IncDecOps.PreDec:
					il.Emit(OpCodes.Ldc_I4_1);
					il.Emit(OpCodes.Sub);
					il.Emit(OpCodes.Dup);
					il.Emit(OpCodes.Starg, parameterInfo.Position-1);
					break;
			}
		}
		
		public void AddGetNumber(long value)
		{
			if (value>=Int32.MinValue && value<=Int32.MaxValue) {
				il.Emit(OpCodes.Ldc_I4, (Int32)value);
			} else {
				il.Emit(OpCodes.Ldc_I8, value);
			}
		}
		
		public void AddGetDouble(double value)
		{
			il.Emit(OpCodes.Ldc_R8, value);
		}
		
		public void AddGetBoolean(bool value)
		{
			il.Emit(OpCodes.Ldc_I4, value ? 1 : 0);
		}
		
		public void AddGetChar(char value)
		{
			il.Emit(OpCodes.Ldc_I4_S, value);
		}
		
		public void AddGetString(string value)
		{
			il.Emit(OpCodes.Ldstr, value);
		}
		
		public void AddGetNull()
		{
			il.Emit(OpCodes.Ldnull);
		}
		
	}
}
