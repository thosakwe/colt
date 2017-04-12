import 'package:code_builder/code_builder.dart';
import 'expression.dart';
import 'node.dart';

class TextNodeContext extends NodeContext {
  final ExpressionContext text;

  TextNodeContext(this.text) : super(':text');

  @override
  ExpressionBuilder compile() =>
      new TypeBuilder('TextNode').newInstance([text.compile()]);
}
