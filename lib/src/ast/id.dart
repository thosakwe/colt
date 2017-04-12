import 'package:code_builder/code_builder.dart';
import 'expression.dart';

class IdExpressionContext implements ExpressionContext {
  final String name;

  IdExpressionContext(this.name);

  @override
  ExpressionBuilder compile() => reference(name);
}
