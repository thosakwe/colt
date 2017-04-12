import 'package:code_builder/code_builder.dart';
import 'function_body.dart';
import 'function_signature.dart';
import 'type.dart';

class FunctionDeclarationContext {
  final FunctionSignatureContext signature;
  final FunctionBodyContext body;
  TypeContext returnType = TypeContext.DYNAMIC;

  FunctionDeclarationContext(this.signature, this.body);

  MethodBuilder compile() {
    var m = new MethodBuilder(signature.name,
        returnType: returnType?.compile() ?? TypeContext.DYNAMIC.compile());

    for (var parameter in signature.parameters) {
      m.addPositional(new ParameterBuilder(parameter.name,
          type: parameter.type?.compile() ?? TypeContext.DYNAMIC.compile()));
    }

    return m..addStatements(body.compile());
  }
}
