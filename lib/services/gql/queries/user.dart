import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final DocumentNode CREATE_USER_MUTATION = gql("""
  mutation(
    \$data: ICreateUserDTO! 
  ) {
    createUser(
      data: \$data
    ) {
      id
      name
      email
      username
      avatar
      biography
      active
      verified
    }
  }
""");

final DocumentNode GET_USER_QUERY = gql("""
 query (\$id: Float!) {
	getUser(id: \$id){
		id
		email
		name
		username
		avatar
		biography
		active
		verified
		created_at
		updated_at
		following
		followed
		profile_details {
			mentions
			medias
			posts
      followed
			followers
		}
	}
}
""");

final DocumentNode UPDATE_USER_MUTATION = gql("""
 mutation(
	\$data: IUpdateUserDTO! 
) {
	updateProfile(
		data: \$data
	) {
		id
		name
		username
	}
}
""");

final DocumentNode GET_PROFILE = gql("""
query {
	getProfile {
		id
		name
		email
		username
		avatar
		biography
		active
		verified
		created_at
		updated_at
		profile_details {
			mentions
			medias
			posts
			followed
			followers
		}
	}
}
""");
