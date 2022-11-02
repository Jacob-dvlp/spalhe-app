import 'package:graphql/client.dart';

final EXPLORE_MEDIAS_QUERY = gql(r"""
 query getExploreMedias($filters: IFilters!) {
	getExploreMedias(filters: $filters) {
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
			published
			is_liked
			medias {
				url
			}
			location {
				name
			}
			mentions {
				user {
					id
					name
          verified
				}
			}
			user {
        id
				name
				username
        avatar
        verified
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
