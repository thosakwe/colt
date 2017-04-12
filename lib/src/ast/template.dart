import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';
import 'annotation.dart';
import 'function.dart';

class TemplateContext {
  final String name;
  final List<AnnotationContext> annotations = [];
  final List<FunctionDeclarationContext> functions = [];

  TemplateContext(this.name);

  LibraryBuilder compile() {
    var rc = new ReCase(name);

    var lib = new LibraryBuilder('colt.${rc.snakeCase}')
      ..addDirective(
          new ImportBuilder('package:html_builder/html_builder.dart'));

    var clazz = new ClassBuilder(rc.pascalCase);

    for (var function in functions) {
      clazz.addMethod(function.compile(), asStatic: true);
    }

    return lib..addMember(clazz);
  }
}