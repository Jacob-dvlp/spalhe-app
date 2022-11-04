import 'package:graphql/client.dart';

final TOGGLE_LIKE_COMMENT = gql(r'''
  mutation toggleLikeComment($comment_id: Float!) {
    toggleLikeComment(comment_id: $comment_id) {
      id
    }
  }
''');

final REPLY_COMMENT_MUTATION = gql(r"""
  mutation replyComment($comment_id: Float!, $text: String!) {
    replyComment(comment_id: $comment_id, text: $text) {
      id
      text
      user {
        id
        name
        avatar
        verified
      }
    }
  }
""");

final GET_ALL_REPLIES_COMMENT_QUERY = gql(r"""
 query allRepliesByCommentId($comment_id: Float!) {
	allRepliesByCommentId(comment_id: $comment_id){
		id
		text
		created_at
		user {
			id
			avatar
			name
			username
      verified
		}
	}
}
""");

final COMMENT_POST_MUTATION = gql(r"""
  mutation ($post_id: Float!, $data: ICreateCommentDTO!) {
    commentPost(post_id: $post_id, data: $data) {
      id
      text
      user {
        id
        name
        avatar
        verified
      }
    }
  }
""");

final GET_COMMENTS_POST = gql(r"""
  query getCommentsPost($filters: IFilters!, $post_id: Float!) {
    getCommentsPost(post_id: $post_id, filters: $filters) {
      meta {
        next_page
        previus_page
        total
        page
      }
      data {
        id
        text
        created_at
        is_liked
        _count {
          likes
          replies
        }
        user {
          id
          username
          avatar
          name
          verified
        }
        replies {
          id
          text
          created_at
          user {
            id
            name
            username
            avatar
          }
        }
      }
    }
  }
""");
