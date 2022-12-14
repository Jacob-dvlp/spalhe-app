import 'package:graphql/client.dart';
import 'package:gql/src/ast/ast.dart';
import 'package:spalhe/services/gql/gql.dart';

Future<QueryResult<Object?>> useMutation<T>(
  DocumentNode query, {
  Map<String, dynamic>? variables,
}) async {
  final client = GQLClient().connect();
  final result = await client.mutate(MutationOptions(
    document: query,
    variables: variables ?? {},
  ));
  if (result.exception?.linkException != null) {
    throw result.exception?.linkException ?? {};
  }
  return result;
}

Future<QueryResult> useQuery(
  DocumentNode query, {
  Map<String, dynamic>? variables,
}) async {
  final client = new GQLClient().connect();
  final result = await client.query(
    QueryOptions(
      document: query,
      variables: variables ?? {},
    ),
  );
  if (result.exception?.linkException != null) {
    throw result.exception?.linkException ?? {};
  }
  return result;
}

Future<Stream<QueryResult<Object?>>> useSubscription(
  DocumentNode query, {
  Map<String, dynamic>? variables,
}) async {
  try {
    final client = new GQLClient().connect();
    final result = await client.subscribe(
      SubscriptionOptions(
        document: query,
        variables: variables ?? {},
      ),
    );
    return result;
  } catch (e) {
    return Stream.empty();
  }
}
