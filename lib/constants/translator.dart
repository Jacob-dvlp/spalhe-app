import 'package:get/get.dart';

class TransalationsMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'forgot_password_message': 'forgot password?',
          'forgot_password_button': 'recover password',
          'signin': 'sign in',
          'password': 'password',
          // login
          'email_required': 'email is required',
          'password_required': 'password is required',
          'password_too_short': 'password too short',
          'email_is_not_valid': 'email is not valid',
          'have_account_message': 'already have an account?',
          'enter_my_account': 'enter my account',
          'your_name': 'your name',
          'your_best_email': 'your best email',
          // singup
          'dont_have_account': 'not have an account yet?',
          'signup': 'sign up',
          'accept_policy_message':
              'by creating an account, you are agreeing to the',
          'privacy_policies': 'privacy policies',
        },
        'pt_BR': {
          'forgot_password_message': 'esqueceu a senha?',
          'forgot_password_button': 'recuperar senha',
          'signin': 'entrar',
          'password': 'senha',
          // login
          'email_required': 'email obrigatório',
          'password_required': 'senha obrigatória',
          'password_too_short': 'senha muito curta',
          'email_is_not_valid': 'email não é válido',
          'have_account_message': 'já tem uma conta?',
          'enter_my_account': 'entrar na minha conta',
          'your_name': 'seu nome',
          'your_best_email': 'seu melhor email',
          // singup
          'dont_have_account': 'ainda não tem uma conta?',
          'signup': 'criar minha conta',
          'accept_policy_message':
              'ao criar uma conta, você estará concordando com as',
          'privacy_policies': 'políticas de privacidade',
        }
      };
}
