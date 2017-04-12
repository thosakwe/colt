import 'package:code_builder/code_builder.dart';
import 'expression.dart';
import 'statement.dart';

class ReturnStatementContext implements StatementContext {
  final ExpressionContext value;

  ReturnStatementContext(this.value);

  @override
  StatementBuilder compile() => value.compile().asReturn();
}
