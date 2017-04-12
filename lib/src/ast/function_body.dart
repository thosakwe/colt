import 'package:code_builder/code_builder.dart';
import 'expression.dart';
import 'statement.dart';

abstract class FunctionBodyContext {
  Iterable<StatementBuilder> compile();
}

class BlockFunctionBodyContext implements FunctionBodyContext {
  final List<StatementContext> statements = [];

  @override
  Iterable<StatementBuilder> compile() => statements.map((s) => s.compile());
}

class ExpressionFunctionBodyContext implements FunctionBodyContext {
  final ExpressionContext expression;

  @override
  Iterable<StatementBuilder> compile() => [expression.compile().asReturn()];

  ExpressionFunctionBodyContext(this.expression);
}
