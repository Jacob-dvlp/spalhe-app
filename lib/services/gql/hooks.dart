import 'package:graphql/client.dart';
import 'package:spalhe/services/gql/gql.dart';

Future<QueryResult<Object?>> useMutation<T>(MutationOptions options) async {
  final client = GQLClient().connect();
  final result = await client.mutate(options);

  if (result.exception?.linkException != null) {
    print({'GQL ERROR => ', result.exception?.linkException});
    throw result.exception?.linkException ?? {};
  }
  return result;
}

Future<QueryResult> useQuery<T>(QueryOptions options) async {
  final client = GQLClient().connect();
  final result = await client.query(options);
  return result;
}
