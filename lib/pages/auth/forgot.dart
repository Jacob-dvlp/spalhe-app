import 'package:spalhe/components/gradient_button.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Recuperação de conta'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 5),
          const Text('Falta pouco para recuperar sua conta'),
          const Text(
            'Digite seu email',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
            ),
          ),
          const SizedBox(height: 15),
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
