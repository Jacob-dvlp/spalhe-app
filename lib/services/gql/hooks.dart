import 'package:graphql/client.dart';
import 'package:spalhe/services/gql/gql.dart';

Future<QueryResult<Object?>> useMutation<T>(query,
    {Map<String, dynamic>? variables}) async {
  final client = GQLClient().connect();
  final result = await client.mutate(MutationOptions(
    document: query,
    variables: variables ?? {},
  ));

  if (result.exception?.linkException != null) {
    print({'GQL ERROR => ', result.exception?.linkException});
    throw result.exception?.linkException ?? {};
  }
  return result;
}

Future<QueryResult> useQuery<T>(query,
    {Map<String, dynamic>? variables}) async {
  final client = GQLClient().connect();
  final result = await client.query(
    QueryOptions(
      document: query,
      variables: variables ?? {},
    ),
  );
  return result;
}