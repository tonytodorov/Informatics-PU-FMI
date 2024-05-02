using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace scsc.Tests
{

	public class VerifyDiagnostics : Diagnostics
	{
		class DiagnosticItem {
			private int line;			
			public int Line {
				get { return line; }
			}
			
			private string message;			
			public string Message {
				get { return message; }
			}
			
			public DiagnosticItem(int line, string message) {
				this.line = line;
				this.message = message;
			}
			
			public override string ToString() {
				return message + "\t on line: " + line;
			}
			
		}
		
		private List<DiagnosticItem> SeenErrors = new List<DiagnosticItem>();
		private List<DiagnosticItem> ExpectedErrors = new List<DiagnosticItem>();
		private string currentSourceFile = null;
		
		public VerifyDiagnostics()
		{
		}
		
		public override void Error(int line, int column, string message)
		{
			SeenErrors.Add(new DiagnosticItem(line, message));
		}
		
		public override void Note(int line, int column, string message)
		{
			throw new NotImplementedException();
		}
		
		public override void Warning(int line, int column, string message)
		{
			throw new NotImplementedException();
		}
		
		public override int GetErrorCount()
		{
			return CompareErrorLists();
		}
		public override void BeginSourceFile(string sourceFile)
		{
			currentSourceFile = sourceFile;
		}
		
		public override void EndSourceFile()
		{
			currentSourceFile = null;
		}
		
		
		private void GetExpectedErrors() {
			StreamReader reader = new StreamReader(currentSourceFile);
			
			Scanner scanner = new Scanner(reader);
			scanner.SkipComments = false;
			Scanner CommentScanner;
			Token t = scanner.Next();
			
			while (!(t is EOFToken)) {
				if (t is CommentToken) {
					CommentScanner = new Scanner(new StringReader((t as CommentToken).value));
					Token ErrorMessage = CommentScanner.Next();
					do {
						if ((ErrorMessage is IdentToken) && (ErrorMessage as IdentToken).value == "expectederror")
							ErrorMessage = CommentScanner.Next();
						
						if (ErrorMessage is StringToken)
						  	ExpectedErrors.Add(new DiagnosticItem(t.line, (ErrorMessage as StringToken).value));
						
						ErrorMessage = CommentScanner.Next();
					} while (!(ErrorMessage is EOFToken));
				}
				t = scanner.Next();
			}
			
			//Debug.WriteLine("----------------------");
			//DumpSeenErrors();
			//DumpExpectedErrors();
		}
		
		private void DumpExpectedErrors() {
			Debug.WriteLine("Errors expected but not seen: " + ExpectedErrors.Count);
			
			foreach (DiagnosticItem error in ExpectedErrors) {
				Debug.WriteLine(error.ToString());
			}
			Debug.WriteLine("\n");
			
		}
		
		private void DumpSeenErrors() {
			Debug.WriteLine("Errors seen but not expected: " + SeenErrors.Count);
			
			foreach (DiagnosticItem error in SeenErrors) {
				Debug.WriteLine(error.ToString());
			}
			Debug.WriteLine("\n");
		}
		
		private int CompareErrorLists() {
			GetExpectedErrors();
			for (int i = SeenErrors.Count - 1; i >= 0; --i) {
				DiagnosticItem seenError = SeenErrors[i];
				// Check whether we had more than one error on line. In that case
				// we can neglect the exact ordering.
				for (int j = ExpectedErrors.Count - 1; j >= 0; --j) {
					DiagnosticItem expectedError = ExpectedErrors[j];
					// If the messages and lines correspond to each other we 
					// pop the pair (seen-expected) from the lists.
					if (seenError.Line == expectedError.Line)			
						if (seenError.Message == expectedError.Message) {
							SeenErrors.Remove(seenError);
							ExpectedErrors.Remove(expectedError);
							// Make sure that if we have repeating expected errors 
							// we are removing only one of them.
							break;
						}
					}
			}
			// Dump the diffs
			if (SeenErrors.Count > 0) {
				DumpSeenErrors();
			}

			if (ExpectedErrors.Count > 0) {
				DumpExpectedErrors();
			}
			return SeenErrors.Count + ExpectedErrors.Count;
		}
	}
}
