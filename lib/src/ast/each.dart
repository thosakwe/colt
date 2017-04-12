import 'package:code_builder/code_builder.dart';
import 'expression.dart';

class EachExpressionContext implements ExpressionContext {
  final String name;
  final ExpressionContext iterated;
  final ExpressionContext child;

  EachExpressionContext(this.name, this.iterated, this.child);

  @override
  ExpressionBuilder compile() {
    var f = new MethodBuilder.closure(returns: child.compile())
      ..addPositional(parameter(name));
    return iterated.compile().invoke('map', [f]);
  }
}
