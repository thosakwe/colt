import 'expression.dart';
import 'package:code_builder/src/builders/expression.dart';

class CallExpressionContext implements ExpressionContext {
  final ExpressionContext target;
  final List<ExpressionContext> arguments = [];

  CallExpressionContext(this.target);

  @override
  ExpressionBuilder compile() =>
      target.compile().call(arguments.map((a) => a.compile()));
}
