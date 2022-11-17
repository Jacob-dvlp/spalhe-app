import 'package:graphql/client.dart';

final GET_MOMENT_VIEW = gql(r'''
query getMomentViews($id: Float!){
	getMomentViews(moment_id: $id) {
		user {
			id
			name
			username
			avatar
			verified
			followed
		}
	}
}

''');

final LIKE_MOMENT_MUTATION = gql(r'''
  mutation likeMoment($id: Float!){
    likeMoment(moment_id: $id)
  }
''');

final VIEW_MOMENT_MUTATION = gql(r'''
  mutation viewMoment($id: Float!){
    viewMoment(moment_id: $id)
  }
''');

final GET_MOMENTS_QUERY = gql("""
  query {
    getMoments {
      id
      avatar
      username
      name
      verified
      moments {
        id
        url
        created_at
        type
        subtype 
      }
    }
  }
""");
