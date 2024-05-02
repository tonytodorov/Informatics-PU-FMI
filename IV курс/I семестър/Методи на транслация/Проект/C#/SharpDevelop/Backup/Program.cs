using System;
using System.Collections.Generic;
using System.IO;

namespace scsc
{
	class Program
	{
		public static int Main(string[] args)
		{
			int i = 0;
			List<string> references = new List<string>();
			references.Add("mscorlib");
			while (i < args.Length && args[i].StartsWith("/r:")) {
				references.Add(args[i].Substring(3));
				i++;
			}

            if (i >= args.Length)
            {
                Console.WriteLine("Syntax: scsc {/r:filename} <source file> [<result exe file>]");
                Console.WriteLine("Example: scsc /r:System.dll /r:System.Xml.dll examle.scs example.exe");
                Console.WriteLine("Warning!!! If you run the program from IDE then set params from a project properties.");
                Console.Read();

                return -1;
            }
            else
            {
                string assemblyName;
                if (args.Length == i + 2) assemblyName = args[i + 1];
                else assemblyName = Path.ChangeExtension(args[i], "exe");

                Compiler.AddReferences(references);
                Compiler.Compile(args[i], assemblyName);
                
                //Console.Read();

                return 0;
            }
		}
	}
}
