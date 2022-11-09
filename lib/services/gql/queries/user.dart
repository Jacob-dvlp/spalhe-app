import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final BLOCK_USER_MUTATION = gql(r"""
 mutation blockUser($user_id: Float!) {
	blockUser(user_id: $user_id)
}
""");

final FOLLOW_USER_MUTATION = gql(r"""
  mutation ($followed_id: Float!) {
    followUser(followed_id: $followed_id) {
      active
      status
	  }
  }
""");

final DocumentNode CREATE_USER_MUTATION = gql(r"""
  mutation(
    $data: ICreateUserDTO! 
  ) {
    createUser(
      data: $data
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

final DocumentNode GET_USER_QUERY = gql(r"""
 query ($id: Float!) {
	getUser(id: $id){
		id
		email
		name
		username
		avatar
		biography
		active
    privated
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

final DocumentNode UPDATE_USER_MUTATION = gql(r"""
 mutation(
	$data: IUpdateUserDTO! 
) {
	updateProfile(
		data: $data
	) {
		id
		name
		username
	}
}
""");

final DocumentNode GET_PROFILE = gql(r"""
query {
	getProfile {
		id
		name
		email
		username
		avatar
		biography
		active
    privated
		verified
		created_at
		updated_at
    sensitive_content
    cover
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

final GET_USERS_QUERY = gql(r"""
  query($filters: IFilters!, $filter_follows: Boolean) {
    getUsers(filters: $filters, filter_follows: $filter_follows) {
      meta {
        page
        per_page
        previus_page
        next_page
        total
      }
      data {
        id
        name
        username
        avatar
        following
        verified
        privated
        followed
			  following
      }
    }
  }
""");
