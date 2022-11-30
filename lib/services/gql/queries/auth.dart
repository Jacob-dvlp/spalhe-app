import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final DELETE_ACCOUNT_MUTATION = gql(r'''
 mutation deleteAccount {
	deleteAccount {
		id
	}
}
''');

final LOGIN_OAUTH = gql(r'''
  mutation loginInWithCredential($data: ILoginOAuth!) {
    loginInWithCredential(data: $data) {
      token
      user {
        id
        name
        email
        avatar
        username
        biography
        active
        privated
        verified
        created_at
        profile_details {
          mentions
          medias
          posts
          followed
          followers
        }
      }
    }
  }
''');

final DocumentNode LOGIN_MUTATION = gql(r"""
 mutation ($data: ILoginDTO!) {
	login(data: $data) {
		token
		user {
			id
			name
			email
			avatar
			username
			biography
			active
			privated
			verified
			created_at
			profile_details {
				mentions
				medias
				posts
				followed
				followers
			}
		}
	}
}

""");
