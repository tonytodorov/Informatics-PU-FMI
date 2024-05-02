namespace scsc
{
    public class Token
    {
        public int line;
        public int column;

        public Token(int line, int column)
        {
            this.line = line;
            this.column = column;
        }

        public TokenType Type { get; }
        public string Value { get; }

        public Token(TokenType type, string value)
        {
            Type = type;
            Value = value;
        }
    }

    public enum TokenType
    {
        Number,
        Ident,
        Delimiter,
        Keyword,
        SpecialSymbol,
        OtherSymbol,
        EOF

    }
}
