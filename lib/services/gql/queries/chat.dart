import 'package:graphql/client.dart';

final CREATE_CHAT_MUTATION = gql(r'''
  mutation createChat($data: ICreateChat!) {
    createChat(data: $data){
      id
      name
      avatar
      is_group
      exit_users_ids
      user {
        id
        name
        status
        avatar
        verified
      }
      last_message {
        message
        created_at
        files {
          id
          url
        }
      }
      count_unread_messages
    }
  }
''');

final SET_VIEWED_MESSAGES = gql(r"""
mutation setViewedMessages($chat_id: String!) {
  setViewedMessages(chat_id: $chat_id){
    id
  }
}
""");

final CHAT_ADD_SUBSCRIPTION = gql(r'''
 subscription chatAdded($user_id: Float!) {
  chatAdded(user_id: $user_id) {
    id
  }
}
''');

final MESSAGE_ADD_SUBSCRIPTION = gql(r'''
 subscription messageAdded($chat_id: String!) {
  messageAdded(chat_id: $chat_id){
    id
			message
			created_at
			user_id
			files {
				id
				type
				url
			}
			user {
				id
				name
        status
				username
				avatar
        verified
			}
  } 
}
''');

final SEND_MESSAGE_MUTATION = gql(r"""
  mutation createChatMessage($chat_id: String!, $message: String!) {
    createChatMessage(data: {
      chat_id: $chat_id, message: $message
    }){
      id
    }
  }
""");

final GET_CHAT_MESSAGE_QUERY = gql(r"""
 query getChatMessages($chat_id: String!){
    getChatMessages(
      chat_id: $chat_id,
      filters: {}
    ) {
      meta {
        next_page
        previus_page
      }
      data {
        id
        message
        created_at
        user_id
        files {
          id
          type
          url
        }
        user {
          id
          name
          status
          avatar
          username
          verified
        }
      }
    }
  }
""");

final GET_CHATS_QUERY = gql("""
  query getChats {
    getChats {
      id
      name
      avatar
      is_group
      exit_users_ids
      user {
        id
        name
        status
        avatar
        verified
      }
      last_message {
        message
        created_at
        files {
          id
          url
        }
      }
      count_unread_messages
    }
  }

""");
