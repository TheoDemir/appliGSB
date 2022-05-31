import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageTest extends StatefulWidget {
  PageTest({this.title}) {
    if (title != null && title!.contains("hello")) {
      vari = "contient hello";
    } else {
      vari = "ne contient pas hello";
    }
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  String? title;
  late String vari;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PageTest> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("page 2"),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        children: [
          Text("PAGE 2"),
          Text("PAGE 2"),
          TextButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  print(image.path);
                } else {
                  print("pas d'image selectionnée");
                }
              },
              child: Text('gallerie')),
        ],
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
