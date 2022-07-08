import 'package:get_storage/get_storage.dart';
import 'package:graphql/client.dart';
import 'package:spalhe/models/auth.dart';

class GQLClient {
  GraphQLClient connect() {
    final _box = GetStorage();
    AuthModel auth = AuthModel.fromJson(_box.read('auth') ?? {});

    final HttpLink httpLink = HttpLink(
      'http://localhost:3000/graphql',
    );

    final WebSocketLink websocketLink = WebSocketLink(
      'ws://localhost:3000/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${auth.token}',
    );

    final Link link = Link.split((request) => request.isSubscription,
        websocketLink, authLink.concat(httpLink));

    final client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );

    return client;
  }
}
