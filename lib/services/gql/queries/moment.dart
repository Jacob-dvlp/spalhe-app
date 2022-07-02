import 'package:graphql/client.dart';

final GET_MOMENTS_QUERY = gql("""
query {
	getMoments {
		id
		avatar
		username
		name
		moments {
			url
			created_at
			type
			subtype
		}
	}
}
""");
