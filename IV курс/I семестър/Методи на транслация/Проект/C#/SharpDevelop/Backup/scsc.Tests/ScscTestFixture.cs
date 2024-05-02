using System;
using System.Diagnostics;
using System.IO;

using NUnit.Core;
using NUnit.Framework;

namespace scsc.Tests
{
	[TestFixture]
	public class ScscTestFixture
	{
		protected static string TestCasesDir 
			= Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
		                   Path.Combine ("..",
		                                 Path.Combine ("..", "TestCases" + Path.DirectorySeparatorChar)));
		
		private static string Normalize(string s)
		{
			char[] CharsToTrim = new char[]{' ','\t'};
			// for Mac, Win, Lin
			return s.Normalize().Replace("\n\r", "\n").Replace("\r\n", "\n").Replace("\r", "\n").Trim(CharsToTrim);
		}
			
		private static void RunTestMethod (string testname)
		{
			string testPath = TestCasesDir + testname;
			string testCasesTmpDir = TestCasesDir + "tmp" + Path.DirectorySeparatorChar;
			string sourceFilePath = testPath + ".scs";
			string exeFilePath =  testCasesTmpDir + testname+ ".exe";
			string resultFilePath = testPath + ".result";
			
			// Replace the default diagnostic client with our new custom one.
			// VerifyDiagnostics analyzes special syntax hidden in the comments
			// and verifies whether an error was expected or not.
			VerifyDiagnostics diag = new VerifyDiagnostics ();
			bool Compiled = Compiler.Compile(sourceFilePath, exeFilePath, diag);
			Assert.IsTrue (Compiled);
			
			// If the compilation was fine we have an assembly.
			// If there is a testname.result file we run the assembly and 
			// compare the output of the assembly and the expected output
			// in the .result file.
			if (File.Exists(resultFilePath)) {
				string resultFileText = Normalize(File.ReadAllText(resultFilePath));
				Process p = new Process();
				p.StartInfo.FileName = exeFilePath;
				p.StartInfo.UseShellExecute = false;
				p.StartInfo.RedirectStandardOutput = true;
				p.StartInfo.RedirectStandardError = true;
				p.StartInfo.ErrorDialog = false;

				p.Start();
				if(!p.WaitForExit(15000))
					p.Kill();

				string output = Normalize(p.StandardOutput.ReadToEnd());
				string error = Normalize(p.StandardError.ReadToEnd());
		
				Assert.AreEqual (resultFileText, output, "Mismatch! Output was not expected:\n");
			}
		}

		[Test]
		public void EmptyProgram()
		{
			RunTestMethod("EmptyProgram");
		}
		
		[Test]
		public void WritelineStatement()
		{
			RunTestMethod("WritelineStatement");
		}
		
		[Test]
		public void WhileStatementSimple()
		{
			RunTestMethod("WhileStatementSimple");
		}
		
		[Test]
		public void WhileIfSimpleNesting()
		{
			RunTestMethod("WhileIf-SimpleNesting");
		}
		
		[Test]
		public void UsingClauseTwoClause()
		{
			RunTestMethod("UsingClause-TwoClause");
		}

		[Test]
		public void UsingClauseSingleClause()
		{
			RunTestMethod("UsingClause-SingleClause");
		}
		
		[Test]
		public void UsingClauseMultipleClause()
		{
			RunTestMethod("UsingClause-MultipleClause");
		}
		
		[Test]
		public void IfWhileSimpleNesting()
		{
			RunTestMethod("If-While-SimpleNesting");
		}
		
		[Test]
		public void IfStatementSimpleWithElse()
		{
			RunTestMethod("IfStatementSimple-WithElse");
		}
		
		[Test]
		public void IfStatementNested1LevelWithElse()
		{
			RunTestMethod("IfStatement-Nested1Level-WithElse");
		}
		
		[Test]
		public void IfStatementNested1Level()
		{
			RunTestMethod("IfStatement-Nested1Level");
		}
		
		[Test]
		public void IfStatementSimple()
		{
			RunTestMethod("IfStatementSimple");
		}
		
		[Test]
		public void FunctionsStatementNested2Levels()
		{
			RunTestMethod("FunctionsStatement-Nested2Levels");
		}
		
		[Test]
		public void FunctionsStatementNested1Level()
		{
			RunTestMethod("FunctionsStatement-Nested1Level");
		}
		
		[Test]
		public void Fibonacci()
		{
			RunTestMethod("Fibonacci");
		}
		
		[Test]
		public void ErrorIfStatementSimple()
		{
			RunTestMethod("Error-IfStatementSimple");
		}
		
		[Test]
		public void ErrorFibonacci()
		{
			RunTestMethod("Error-Fibonacci");
		}
		
		[Test]
		public void ErrorFunctionsStatementNested1Level()
		{
			RunTestMethod("Error-FunctionsStatement-Nested1Level");
		}
		
		[Test]
		public void ErrorFunctionsStatementNested2Levels()
		{
			RunTestMethod("Error-FunctionsStatement-Nested2Levels");
		}
		
		[Test]
		public void ErrorIfWhileSimpleNesting()
		{
			RunTestMethod("Error-If-While-SimpleNesting");
		}
		
		[Test]
		public void ErrorIfStatementNested1LevelWithElse()
		{
			RunTestMethod("Error-IfStatement-Nested1Level-WithElse");
		}
		
		[Test]
		public void ErrorIfStatementNested1Level()
		{
			RunTestMethod("Error-IfStatement-Nested1Level");
		}
		
		[Test]
		public void ErrorIfStatementSimpleWithElse()
		{
			RunTestMethod("Error-IfStatementSimple-WithElse");
		}
		
		[Test]
		public void ErrorUsingClauseMultipleClause()
		{
			RunTestMethod("Error-UsingClause-MultipleClause");
		}
		
		[Test]
		public void ErrorUsingClauseSingleClause()
		{
			RunTestMethod("Error-UsingClause-SingleClause");
		}
		
		[Test]
		public void ErrorUsingClauseTwoClause()
		{
			RunTestMethod("Error-UsingClause-TwoClause");
		}
		
		[Test]
		public void ErrorWhileIfSimpleNesting()
		{
			RunTestMethod("Error-WhileIf-SimpleNesting");
		}
		
		[Test]
		public void ErrorWhileStatementSimple()
		{
			RunTestMethod("Error-WhileStatementSimple");
		}
		
		[Test]
		public void ErrorWritelineStatement()
		{
			RunTestMethod("Error-WritelineStatement");
		}
		
	}
}
