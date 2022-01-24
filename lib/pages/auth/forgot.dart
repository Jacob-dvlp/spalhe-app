import 'package:spalhe/components/gradient_button.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Recuperação de conta'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
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
          GradientButton(
            onPress: () => {},
            text: 'ENVIAR UM CÓDIGO',
            disabled: false,
            loading: false,
          ),
        ],
      ),
    );
  }
}
