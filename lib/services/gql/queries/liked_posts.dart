import 'package:graphql/client.dart';

final GET_LIKED_POSTS_QUERY = gql(r"""
query getLikedPosts($user_id: Float!, $filters: IFilters!) {
	getLikedPosts(user_id: $user_id, filters: $filters) {
		meta {
			page
			per_page
			total
			previus_page
			next_page
		}
		data {
			id
			text
			created_at
			is_liked
			medias {
				type
			}
			user {
				name
				id
				avatar
			}
			location {
				id
				name
			}
			_count {
				mentions
				likes
				comments
			}
			mentions {
				user {
					name
					id
					avatar
          verified
				}
			}
		}
	}
}
""");
