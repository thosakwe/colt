import 'package:compiler_tools/compiler_tools.dart';
import 'package:string_scanner/string_scanner.dart';
import 'token_type.dart';

final RegExp _WHITESPACE = new RegExp(r'[ \r\t\n]+');

final Map<Pattern, TokenType> _PATTERNS = {
  '{': TokenType.LBRACE,
  '}': TokenType.RBRACE,
  '[': TokenType.LBRACKET,
  ']': TokenType.RBRACKET,
  '(': TokenType.LPAREN,
  ')': TokenType.RPAREN,
  ';': TokenType.SEMI,
  '>': TokenType.ANGLE,
  '@': TokenType.ARROBA,
  '=>': TokenType.ARROW,
  '*': TokenType.ASTERISK,
  ',': TokenType.COMMA,
  '++': TokenType.INCREMENT,
  '--': TokenType.DECREMENT,
  '-': TokenType.MINUS,
  '.': TokenType.DOT,
  '=': TokenType.EQUALS,
  '+': TokenType.PLUS,
  '/': TokenType.SLASH,
  '&&': TokenType.BOOL_AND,
  '=': TokenType.EQUALS,
  '!=': TokenType.BOOL_NOT_EQUALS,
  '!': TokenType.NOT,
  '||': TokenType.BOOL_OR,
  'each': TokenType.EACH,
  'if': TokenType.IF,
  'in': TokenType.IN,
  'else': TokenType.ELSE,
  'return': TokenType.RETURN,
  'var': TokenType.VAR,
  'true': TokenType.BOOLEAN,
  'false': TokenType.BOOLEAN,
  new RegExp(r'-?[0-9]+(\.[0-9]+)?((E|e)-?[0-9]+)?'): TokenType.NUMBER,
  new RegExp(r"'(([^'\n\r])|(\\')|(\\(n|r)))*'"):
      TokenType.SINGLE_QUOTED_STRING,
  new RegExp(r'"(([^"\n\r])|(\\")|(\\(n|r)))*"'):
      TokenType.DOUBLE_QUOTED_STRING,
  new RegExp(r'`[^`]*`'): TokenType.TEMPLATE_STRING,
  new RegExp(r'[_a-zA-Z]+[_a-zA-Z0-9-]*'): TokenType.ID
};

class Scanner {
  LineScannerState _invalidState;
  final List<SyntaxError> errors = [];
  final List<Token<TokenType>> tokens = [];

  void flush(SpanScanner scanner) {
    if (_invalidState != null) {
      var span = scanner.spanFrom(_invalidState);
      tokens.add(new Token(TokenType.INVALID, span: span));
      _invalidState = null;
    }
  }

  void scan(String text, {sourceUrl}) {
    var scanner = new SpanScanner(text, sourceUrl: sourceUrl);

    while (!scanner.isDone) {
      if (scanner.scan(_WHITESPACE))
        continue;
      else {
        List<Token<TokenType>> potential = [];

        _PATTERNS.forEach((k, v) {
          if (scanner.matches(k))
            potential.add(new Token(v, span: scanner.lastSpan));
        });

        if (_PATTERNS.isEmpty) {
          scanner.readChar();
        } else {
          flush(scanner);
          potential.sort((a, b) => b.text.length.compareTo(a.text.length));
          var token = potential.first;
          tokens.add(token);
          scanner.scan(token.text);
        }
      }
    }
  }
}
