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
        followed
			}
      post {
        id
        text
        published
        user_id
        is_saved
        is_liked
        created_at
        user {
          name
          id
          username
          avatar
          verified
          followed
        }
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
          name
          id
          username
          avatar
          verified
          followed
        }
				created_at
				_count {
					likes
					replies
				}
				is_liked
			}
		}
	}
}
""");
