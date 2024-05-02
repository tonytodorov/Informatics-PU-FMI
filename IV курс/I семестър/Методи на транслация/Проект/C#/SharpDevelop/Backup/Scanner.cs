using System;
using System.IO;
using System.Text;

namespace scsc
{
	public class Scanner
	{
		const char EOF = '\u001a';
		const char CR = '\r';
		const char LF = '\n';
		const char Escape = '\\';
		
    	static readonly string keywords =
			" object void null using if else while return break continue class as is ";
    	static readonly string specialSymbols1 =
    		"%()*,;[]{}~";
    	static readonly string specialSymbols2 =
    		"!&|+-<=>";
    	static readonly string specialSymbols2Pairs =
    		" != && || ++ -- <= == >= ";
    	
		private TextReader reader;
		
		private char ch;
		private int line, column;
		
		private bool skipComments = true;	
		public bool SkipComments {
			get { return skipComments; }
			set { skipComments = value; }
		}
		
		public Scanner(TextReader reader)
		{
			this.reader = reader;
			this.line = 1;
			this.column = 0;
			ReadNextChar();
		}
		
		public void ReadNextChar()
		{
			int ch1 = reader.Read();
			column++;
			ch = (ch1<0) ? EOF : (char)ch1;
			if (ch==CR) {
				line++;
				column = 0;
			} else if (ch==LF) {
				column = 0;
			}
		}
		
		public char UnEscape(char c)
		{
			switch (c) {
				case 't': return '\t';
				case 'n': return '\n';
				case 'r': return '\r';
				case 'f': return '\f';
				case '\'': return '\'';
				case '"': return '\"';
				case '0': return '\0';
				case Escape: return Escape;
				default:  return c;
			}
		}
		
		public Token Next()
		{
			int start_column;
			int start_line;
			while (true) {
				start_column = column;
				start_line = line;
				if (ch>='a' && ch<='z' || ch>='A' && ch<='Z' || ch=='_' || ch=='.') {
					StringBuilder s = new StringBuilder();
					while (ch>='a' && ch<='z' || ch>='A' && ch<='Z' || ch=='_' || ch=='.' || ch>='0' && ch<='9') {
						s.Append(ch);
						ReadNextChar();
					}
					string id = s.ToString();
  					if (id.Equals("false") || id.Equals("true") ) {
						return new BooleanToken(start_line, start_column, id.Equals("true"));
					} else if (keywords.Contains(" "+id+" ")) {
						return new KeywordToken(start_line, start_column, id);
					}
					return new IdentToken(start_line, start_column, id);
				} else if (ch>='0' && ch<='9') {
					StringBuilder s = new StringBuilder();
					while (ch>='0' && ch<='9') {
						s.Append(ch);
						ReadNextChar();
					}
					if (ch=='.') {
						s.Append(ch);
						ReadNextChar();
						while (ch>='0' && ch<='9') {
							s.Append(ch);
							ReadNextChar();
						}
						return new DoubleToken(start_line, start_column, Convert.ToDouble(s.ToString(), System.Globalization.NumberFormatInfo.InvariantInfo));
					}
					return new NumberToken(start_line, start_column, Convert.ToInt64(s.ToString()));
				} else if (ch=='\'') {
					ReadNextChar();
					char ch1 = ch;
					if (ch == Escape) {
						ReadNextChar();
						ch1 = UnEscape(ch);
					}
					ReadNextChar();
					if (ch=='\'') ReadNextChar();
					return new CharToken(start_line, start_column, ch1);
				} else if (ch=='"') {
					StringBuilder s = new StringBuilder();
					ReadNextChar();
					while (ch!='"' && ch!=EOF) {
						char ch1 = ch;
						if (ch == Escape) {
							ReadNextChar();
							ch1 = UnEscape(ch);
						}
						s.Append(ch1);
						ReadNextChar();
					}
					ReadNextChar();
					return new StringToken(start_line, start_column, s.ToString());
				} else if (specialSymbols1.Contains(ch.ToString())) {
					char ch1 = ch;
					ReadNextChar();
					return new SpecialSymbolToken(start_line, start_column, ch1.ToString());
				} else if (specialSymbols2.Contains(ch.ToString())) {
					char ch1 = ch;
					ReadNextChar();
					char ch2 = ch;
					if (specialSymbols2Pairs.Contains(" "+ch1+ch2+" ")) {
						ReadNextChar();
						return new SpecialSymbolToken(start_line, start_column, ch1.ToString()+ch2);
					}
					return new SpecialSymbolToken(start_line, start_column, ch1.ToString());
				} else if (ch==' ' || ch=='\t' || ch==CR || ch==LF) {
					ReadNextChar();
					continue;
				} else if (ch=='/') {
					char ch1 = ch;
					ReadNextChar();
					if (ch=='/') {
						if (skipComments) {
							while (ch!=CR && ch!=LF && ch!=EOF) {
								ReadNextChar();
							}
							ReadNextChar();
						} else {
							StringBuilder s = new StringBuilder();
							while (ch!=CR && ch!=LF && ch!=EOF) {
								ReadNextChar();
								s.Append(ch);
							}
							ReadNextChar();
							return new CommentToken(start_line, start_column, s.ToString(), true);
						}
					} else if (ch=='*') {
						if (skipComments) {
							ReadNextChar();
							do {
								while (ch!='*' && ch!=EOF) {
									ReadNextChar();
								}
								ReadNextChar();
							} while (ch!='/' && ch!=EOF);
							ReadNextChar();
						} else {
							StringBuilder s = new StringBuilder();
							ReadNextChar();
							do {
								while (ch!='*' && ch!=EOF) {
									s.Append(ch);
									ReadNextChar();
								}
								ReadNextChar();
							} while (ch!='/' && ch!=EOF);
							ReadNextChar();
							return new CommentToken(start_line, start_column, s.ToString(), false);
						}
					} else return new SpecialSymbolToken(start_line, start_column, ch1.ToString());
					continue;
				} else if (ch==EOF) {
					return new EOFToken(start_line, start_column);
				} else {
					string s = ch.ToString();
					ReadNextChar();
					return new OtherToken(start_line, start_column, s);
				}
			}
		}
	}
}
