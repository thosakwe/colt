import 'expression.dart';
import 'package:code_builder/src/builders/expression.dart';

class BinaryExpressionContext implements ExpressionContext {
  final ExpressionContext left, right;
  final String op;

  BinaryExpressionContext(this.left, this.op, this.right);

  @override
  ExpressionBuilder compile() {
    var l = left.compile(), r = right.compile();

    switch (op) {
      case '*':
        return l * r;
      case '/':
        return l / r;
      case '+':
        return l + r;
      case '-':
        return l - r;
      default:
        throw new UnsupportedError('Unknown operator "$op".');
    }
  }
}
