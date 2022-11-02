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
			type_id
			
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
		}
	}
}
""");
