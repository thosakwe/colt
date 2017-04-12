# colt
An elegant, functional templating engine for Dart.

Colt can turn this:

```colt
@doctype(html)
Node main(String title) => html {
    head {
        title > title
    },
    body {
        h1 > title,
        p > 'Welcome to Colt!'
    }
};
```

into this Dart code:

```dart
import 'package:html_builder/html_builder.dart';

class Hello {
    static Node main(String title) {
        return h('html', {}, [
            h('head', {}, [
                h('title', {}, [
                    text(title)
                ])
            ]),
            h('body', {}, [
                h('h1', {}, [
                    text(title)
                ]),
                h('p', {}, [
                    text('Welcome to Colt!')
                ])
            ])
        ]);
    }
}
```

Colt can also interpret your templates and run them on-the-fly,
without prior compilation:

```dart
import 'dart:io';
import 'package:colt/colt.dart';
import 'package:html_builder/html_builder.dart';

main() async {
    var colt = new Colt();
    var template = await colt.compile(new File('views/hello.dart'));
    var document = template.main('Hello, world!');
    var renderedHtml = new StringRenderer().render(document);
}
```