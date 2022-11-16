import 'package:graphql/client.dart';

final GET_FOLLOWERS_QUERY = gql(r'''
query getFollowers($user_id: Float!, $filters: IFilters!) {
	getFollowers(filters: $filters, user_id: $user_id) {
		meta {
			next_page
			previus_page
			page
			per_page
			total
		}
		data {
			active
			status
			follower {
				id
				name
				username
				avatar
        followed
        verified
			}
		}
	}
}
''');

final GET_FOLLOWEDS_QUERY = gql(r'''
query getFollowed($user_id: Float!, $filters: IFilters!) {
	getFollowed(filters: $filters, user_id: $user_id) {
		meta {
			next_page
			previus_page
			page
			per_page
			total
		}
		data {
			active
			status
			followed {
				id
				name
				username
				avatar
        followed
        verified
			}
		}
	}
}
''');
