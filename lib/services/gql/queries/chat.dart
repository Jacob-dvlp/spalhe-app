import 'package:graphql/client.dart';

final GET_CHATS_QUERY = gql("""
  query {
    getChats{
      id
      messages {
        text
        id
        medias
        user_id
        created_at
      }
      user {
        id
        name
        avatar
        verified
      }
    }
  }
""");
