import 'package:flutter/material.dart';
import 'package:spalhe/components/layout/button/button.dart';
import 'package:spalhe/components/layout/list_view_wraper/list_view.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperação de conta'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListViewWraper(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 5),
          Text('Falta pouco para recuperar sua conta'),
          Text(
            'Digite seu email',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
            ),
          ),
          SizedBox(height: 15),
          Button(
            title: 'Enviar email',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
