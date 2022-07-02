import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final DocumentNode LOGIN_MUTATION = gql("""
 mutation(\$data: ILoginDTO!) {
	login(
		data: \$data
	){
		token
		user {
			id
			name
			email
			avatar
			username
			biography
			active
			verified
			created_at
			profile_details {
				mentions
				medias
				posts
			}
		}
	}
}
""");
