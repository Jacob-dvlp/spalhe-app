import 'package:get/get.dart';
import 'package:spalhe/language/account.dart';
import 'package:spalhe/language/explore.dart';
import 'package:spalhe/language/tabs.dart';
import 'package:spalhe/language/user_profile.dart';
import 'package:spalhe/language/validations.dart';

class TransalationsMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'forgot_password_message': 'forgot password?',
          'forgot_password_button': 'recover password',
          'signin': 'sign in',
          'password': 'password',
          // login
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
          'hello': 'hello,',
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
          'following': 'following',
          'followed': 'followed',
          'follow': 'follow',
          'no_publication_found': 'No publication found',
          'meet_friends': 'meet friends',
          'edit_profile': 'edit profile',
          'followers': 'followers',
          'posts': 'posts',
          'media': 'media',
          'mentions': 'mentions',
          'save': 'save',
          ...TABS_EN_US,
          ...EXPLORE_EN_US,
          ...VALIDATIONS_LANGUAGES_EN_US,
          ...USER_PROFILE_LANGUAGE_EN_US,
          ...ACCOUNT_LANGUAGE_EN_US,
          'chat_screen_input_placeholder': 'type a message',
          'language': 'language',
        },
        'pt_BR': {
          'forgot_password_message': 'esqueceu a senha?',
          'forgot_password_button': 'recuperar senha',
          'signin': 'entrar',
          'password': 'senha',
          // login
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
          'hello': 'olá,',
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
          'following': 'seguindo',
          'followed': 'seguido',
          'follow': 'seguir',
          'followers': 'seguidores',
          'no_publication_found': 'nenhuma publicação encontrada',
          'meet_friends': 'encontrar amigos',
          'edit_profile': 'editar perfil',
          'posts': 'publicações',
          'media': 'mídias',
          'mentions': 'menções',
          'save': 'salvar',
          ...TABS_PT_BR,
          ...EXPLORE_PT_BR,
          ...VALIDATIONS_LANGUAGES_PT_BR,
          ...USER_PROFILE_LANGUAGE_PT_BR,
          ...ACCOUNT_LANGUAGE_PT_BR,
          'chat_screen_input_placeholder': 'digite sua mensagem',
          'language': 'idioma',
        }
      };
}
