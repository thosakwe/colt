import 'package:colt/src/language/scan.dart';
import 'package:colt/src/language/token_type.dart';
import 'package:compiler_tools/compiler_tools.dart';
import 'package:matcher/matcher.dart';
export 'package:colt/src/language/scan.dart';
export 'package:colt/src/language/token_type.dart';

Matcher equalsScanned(Iterable<TokenType> expected) =>
    new _EqualsScanned(expected);

class _EqualsScanned extends Matcher {
  final Iterable<TokenType> _expected;
  List<Token<TokenType>> _tokens;

  _EqualsScanned(this._expected);

  @override
  Description describe(Description description) =>
      description.add('matches token type sequence: $_expected');

  @override
  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    print('equalsScanned failed: ${matchState["reason"]}');
    print('Tokens: ');

    for (var token in _tokens) {
      print('  "${token.text.replaceAll('\n', '\\n ')}" => ${token.type}');
    }

    return super
        .describeMismatch(item, mismatchDescription, matchState, verbose);
  }

  @override
  bool matches(String item, Map matchState) {
    var scanner = new Scanner()..scan(item);

    if (scanner.errors.isNotEmpty)
      throw scanner.errors.first;
    else
      _tokens = scanner.tokens;

    return equals(_expected.toList())
        .matches(_tokens.map<TokenType>((t) => t.type).toList(), matchState);
  }
}
