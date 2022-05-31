import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';

class User {
  final int userId;
  final String month;
  final String nbJustificatifs;
  final String montantValide;
  final String dateModif;

  const User({
    required this.userId,
    required this.month,
    required this.nbJustificatifs,
    required this.montantValide,
    required this.dateModif,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        month: json['month'],
        montantValide: json['montantValide'],
        nbJustificatifs: json['nbJustificatifs'],
        dateModif: json['dateModif']);
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'month': month,
        'montantValide': montantValide,
        'nbJustificatifs': nbJustificatifs,
        'dateModif': dateModif,
      };
}

class ConnexionPage extends StatefulWidget {
  ConnexionPage();

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  late Future<User> jsonResponse;
  bool loaded = false;
  String resultat = "pas encore rafraichit";

  Future<User> fetchUser() async {
    var data = {
      'login': textEditingControllerMail.text,
      'mdp': textEditingControllerPw.text
    };

    Uri uri = Uri.parse(
        'http://192.168.0.44/index.php?uc=connexionData&action=valideConnexionData');
    final response = await http.post(
      uri,
      // body: body,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      encoding: Encoding.getByName('utf-8'),
      body: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        loaded = true;
        resultat = "page rafraichie";
      });
      print("jsonResponse : \n" + response.body.toString());
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerMail = TextEditingController();
  TextEditingController textEditingControllerPw = TextEditingController();

  // postId() async {
  // Uri uri = Uri.parse(
  //     'http://localhost/index.php?uc=connexionData&action=valideConnexionData');
  // var data = {
  //   'login': textEditingControllerMail.text,
  //   'mdp': textEditingControllerPw.text,
  // };

  // //var body = jsonEncode(data);
  // http.Response response = await http.post(uri, body: data);
  // }

  @override
  void initState() {
    textEditingControllerMail.text = 'lvillachane';
    textEditingControllerPw.text = 'jux7g';
    jsonResponse = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Email',
              ),
              controller: textEditingControllerMail,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: textEditingControllerPw,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('not Validated'),
                  ));
                }
              },
              child: const Text('Submit'),
            ),
            Text("id : lvillachane"),
            Text("pass : jux7g"),
            if (loaded) JsonTable(jsonResponse),
          ],
        ),
      ),
    ));
  }
}
