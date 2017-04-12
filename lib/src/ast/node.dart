import 'package:code_builder/code_builder.dart';
import 'attribute.dart';
import 'expression.dart';

class NodeContext implements ExpressionContext {
  final String tagName;
  final List<AttributeContext> attributes = [];
  final List<ExpressionContext> children = [];

  NodeContext(this.tagName);

  Map<String, ExpressionBuilder> compileAttributes() {
    Map<String, dynamic> result = {};

    for (var attribute in attributes) {
      if (result.containsKey(attribute.name)) {
        var cur = result[attribute.name];

        if (cur is List)
          cur.add(attribute.value.compile());
        else
          result[attribute.name] = [cur, attribute.value.compile()];
      } else {
        result[attribute.name] = attribute.value.compile();
      }
    }

    return result.keys.fold<Map<String, ExpressionBuilder>>({}, (out, k) {
      var v = result[k];
      return out..[k] = v is List ? list(v) : v;
    });
  }

  @override
  ExpressionBuilder compile() {
    return reference('h').call(
        [map(compileAttributes()), list(children.map((c) => c.compile()))]);
  }
}