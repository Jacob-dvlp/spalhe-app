import 'package:graphql/client.dart';

final NOTIFICATION_QUERY = gql(r"""
query ($filters: IFilters!) {
	getNotifications (filters: $filters) {
		meta {
			page
			next_page
			previus_page
		}
		data {
			id
			title
			body
			type	
			post_id
			comment_id
			moment_id
			viewed
			my_user_id
			created_at
			user {
				name
				id
				username
				avatar
        verified
			}
      post {
        id
        text
        published
        user_id
        is_saved
        is_liked
        _count {
          mentions
          likes
          comments
          reposts
          medias
        }
      }
      comment {
        id
        text
        user {
          id
          name
          avatar
          verified
        }
      }
		}
	}
}
""");
