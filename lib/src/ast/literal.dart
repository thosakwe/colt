import 'package:code_builder/code_builder.dart';
import 'expression.dart';

class LiteralExpressionContext implements ExpressionContext {
  final value;

  LiteralExpressionContext(this.value);

  @override
  ExpressionBuilder compile() => literal(value);
}
