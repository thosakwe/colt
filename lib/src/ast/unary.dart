import 'expression.dart';
import 'package:code_builder/src/builders/expression.dart';

class UnaryExpressionContext implements ExpressionContext {
  final ExpressionContext expression;
  final String op;
  final bool prefix;

  UnaryExpressionContext(this.expression, this.op, this.prefix);

  @override
  ExpressionBuilder compile() {
    var l = expression.compile();

    switch (op) {
      case '++':
        return l.increment(prefix);
      case '--':
        // TODO: Is this prefix or postfix???
        return l.decrement();
      default:
        throw new UnsupportedError('Unknown operator "$op".');
    }
  }
}
