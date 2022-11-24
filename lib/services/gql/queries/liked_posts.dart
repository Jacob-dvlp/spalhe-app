import 'package:graphql/client.dart';

final GET_LIKED_POSTS_QUERY = gql(r"""
query getLikedPosts($filters: IFilters!) {
	getLikedPosts(filters: $filters) {
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
        url
			}
			user {
        username
				name
				id
				avatar
        verified
        followed
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
		}
	}
}
""");
