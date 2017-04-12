import 'package:code_builder/code_builder.dart';
import 'expression.dart';
import 'statement.dart';

class IfStatementContext implements StatementContext {
  final IfClause mainClause;
  final List<IfClause> clauses = [];
  ElseClause elseClause;

  IfStatementContext(this.mainClause);

  @override
  StatementBuilder compile() {
    var members = [];

    for (var clause in clauses) {
      members.add(ifThen(clause.condition.compile(),
          clause.statements.map((s) => s.compile())));
    }

    if (elseClause != null)
      members.add(elseThen(elseClause.statements.map((s) => s.compile())));

    return ifThen(
        mainClause.condition.compile(),
        []
          ..addAll(mainClause.statements.map((s) => s.compile()))
          ..addAll(members));
  }
}

class IfClause {
  final ExpressionContext condition;
  final List<StatementContext> statements = [];

  IfClause(this.condition);
}

class ElseClause {
  final List<StatementContext> statements = [];
}
