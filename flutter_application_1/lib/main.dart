import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String generatedPassword = '';
  List<String> passwordHistory = [];

  void _generatePassword() {
    setState(() {
      generatedPassword = randomAlphaNumeric(12);
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: generatedPassword));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Mot de passe copié dans le presse-papiers'),
      duration: Duration(seconds: 2),
    ));
  }

  void _addToHistory() {
    setState(() {
      passwordHistory.add(generatedPassword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mot de passe généré :',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              generatedPassword,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _generatePassword,
                  child: Text('Générer un mot de passe'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _copyToClipboard,
                  child: Text('Copier'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addToHistory,
                  child: Text('Ajouter à l\'historique'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Historique des mots de passe:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: passwordHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(passwordHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}