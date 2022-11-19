import 'package:get/get.dart';

final TABS_PT_BR = {
  'home': 'home',
  'explore': 'explorar',
  'play': 'play',
  'chat': 'chat',
  'notifications': 'notificações',
};

final TABS_EN_US = {
  'home': 'home',
  'explore': 'explore',
  'play': 'play',
  'chat': 'chat',
  'notifications': 'notifications',
};

final EXPLORE_PT_BR = {
  'popular_hashtags': 'hashtags populares',
  'recommended_users': 'usuários recomendados',
  'photos_and_videos': '+ fotos e vídeos',
  'search_users_explore': 'busque pelo nome ou nome de usuário',
};

final EXPLORE_EN_US = {
  'popular_hashtags': 'popular hashtags',
  'recommended_users': 'recommended users',
  'photos_and_videos': '+ photos and videos',
  'search_users_explore': 'search by name or username',
};

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
          // home
          'hello': 'hello',
          // posts
          'post': 'post',
          'new_post': 'new post',
          'what_do_you_want_to_spread': 'what do you want to spread?',
          'post_button': 'publish',
          'see_who_liked': 'see who liked',
          'save_post': 'save post',
          'delete_post': 'delete post',
          'remove_save_post': 'remove from saves',
          'report_post': 'report post',
          'report_post_message': 'are you sure you want to report this post?',
          'see_less_posts_like_this': 'see less posts like this',
          'choose_location': 'choose location',
          'enter_the_address': 'enter the address',
          'enter_your_comment': 'enter your comment',
          ...TABS_EN_US,
          ...EXPLORE_EN_US,
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
          // home
          'hello': 'olá',
          // post
          'post': 'publicação',
          'new_post': 'novo post',
          'what_do_you_want_to_spread': 'o que você quer espalhar?',
          'post_button': 'publicar',
          'see_who_liked': 'ver quem gostou',
          'save_post': 'salvar publicação',
          'delete_post': 'excluir publicação',
          'remove_save_post': 'remover dos salvos',
          'report_post': 'denunciar publicação',
          'report_post_message': 'tem certeza que deseja denunciar este post?',
          'see_less_posts_like_this': 'ver menos posts como este',
          'choose_location': 'escolher localização',
          'enter_the_address': 'digite o endereço',
          ...TABS_PT_BR,
          ...EXPLORE_PT_BR,
        }
      };
}
