import 'package:get_storage/get_storage.dart';
import 'package:graphql/client.dart';
import 'package:spalhe/models/auth.dart';

class GQLClient {
  GraphQLClient connect() {
    final HttpLink httpLink = HttpLink(
      'http://localhost:3000/graphql',
    );

    final _box = GetStorage();
    AuthModel auth = AuthModel.fromJson(_box.read('auth') ?? {});

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${auth.token}',
    );

    final Link link = authLink.concat(httpLink);

    final client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );

    return client;
  }
}
