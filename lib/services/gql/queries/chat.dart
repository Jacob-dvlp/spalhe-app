import 'package:graphql/client.dart';

final CHAT_MESSAGE_SUBSCRIPTION = gql(r"""
  subscription ($chat_id: Float!) {
    chatAdded(chat_id: $chat_id) {
      id
      messages {
        text
        user_id
        user {
          id
          name
          username
          avatar
          verified
        }
        medias
        chat_id
        created_at
        id
      }
    }
  }
""");

final SEND_MESSAGE_MUTATION = gql(r"""
  mutation ($user_id: Float!, $message: String!) {
    createChatMessage(user_id: $user_id, message: {
      text: $message,
    }){
      id
    }
  }
""");

final GET_CHAT_MESSAGE_QUERY = gql(r"""
  query ($chat_id: Float!) {
    getChatMessages(chat_id: $chat_id){
      text
      created_at
      chat_id
      user {
        id
        name
        username
        avatar
        verified
      }
    }
  }
""");

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
