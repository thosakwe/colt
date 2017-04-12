import 'package:code_builder/code_builder.dart';
import 'id.dart';

class TypeContext {
  final IdExpressionContext name;

  static final TypeContext DYNAMIC =
      new TypeContext(new IdExpressionContext('dynamic'));

  TypeContext(this.name);

  TypeBuilder compile() => new TypeBuilder(name.name);
}
