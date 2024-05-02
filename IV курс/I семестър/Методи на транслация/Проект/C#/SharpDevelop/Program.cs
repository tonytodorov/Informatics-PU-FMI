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
            while (i < args.Length && args[i].StartsWith("/r:"))
            {
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

                Console.Read();

                return 0;
            }
        }

        private string input;
        private int index;

        public Token NextToken()
        {
            if (index >= input.Length)
            {
                return new Token(TokenType.EOF, "");
            }

            while (char.IsWhiteSpace(input[index]))
            {
                index++;
                if (index >= input.Length)
                {
                    return new Token(TokenType.EOF, "");
                }
            }

            if (char.IsDigit(input[index]))
            {
                return ReadNumber();
            }
            else if (char.IsLetter(input[index]))
            {
                return ReadIdentifier();
            }
            else if (input[index] == '=')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "=");
            }
            else if (input[index] == '(')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "(");
            }
            else if (input[index] == ')')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, ")");
            }
            else if (input[index] == ';')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, ";");
            }
            else if (input[index] == '+')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "+");
            }
            else if (input[index] == '-')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "-");
            }
            else if (input[index] == '*')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "*");
            }
            else if (input[index] == '|')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "|");
            }
            else if (input[index] == '/')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "/");
            }
            else if (input[index] == '%')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "%");
            }
            else if (input[index] == '&')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "&");
            }
            else if (input[index] == '~')
            {
                index++;
                return new Token(TokenType.SpecialSymbol, "~");
            }
            else
            {
                index++;
                return new Token(TokenType.OtherSymbol, input[index - 1].ToString());
            }
        }

        private Token ReadNumber()
        {
            int start = index;
            while (index < input.Length && char.IsDigit(input[index]))
            {
                index++;
            }
            return new Token(TokenType.Number, input.Substring(start, index - start));
        }

        private Token ReadIdentifier()
        {
            int start = index;
            while (index < input.Length && (char.IsLetterOrDigit(input[index]) || input[index] == '_'))
            {
                index++;
            }
            string ident = input.Substring(start, index - start);
            if (ident == "scanf" || ident == "printf")
            {
                return new Token(TokenType.Keyword, ident);
            }
            else
            {
                return new Token(TokenType.Ident, ident);
            }
        }
    }
}