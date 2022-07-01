import 'package:get_storage/get_storage.dart';
import 'package:graphql/client.dart';
import 'package:spalhe/models/auth.dart';

class GQLClient {
  GraphQLClient connect() {
    final HttpLink httpLink = HttpLink(
      'https://7e64-2804-14d-32a1-8b4a-3d70-4b60-67f-b4dc.ngrok.io/graphql',
    );

    final _box = GetStorage();
    AuthModel auth = AuthModel.fromJson(_box.read('@auth') ?? {});

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
