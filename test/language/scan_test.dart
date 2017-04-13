import 'package:test/test.dart';
import 'common.dart';

main() {
  group('simple', () {
    test('tag+attributes', () {
      expect(
          'foo(bar="baz")',
          equalsScanned([
            TokenType.ID,
            TokenType.LPAREN,
            TokenType.ID,
            TokenType.EQUALS,
            TokenType.DOUBLE_QUOTED_STRING,
            TokenType.RPAREN
          ]));
    });
  });

  group('syntax errors', () {
    test('invalid character', () {
      var scanner = new Scanner();
      scanner.scan('"Percent sign unrecognized..." %');
      print(scanner.errors);
      expect(scanner.errors, isNotEmpty);
    });
  });
}