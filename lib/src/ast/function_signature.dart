import 'parameter.dart';
import 'type.dart';

class FunctionSignatureContext {
  final String name;
  TypeContext returnType;
  final List<ParameterContext> parameters = [];

  FunctionSignatureContext(this.name);
}