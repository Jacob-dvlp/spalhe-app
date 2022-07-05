import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final DocumentNode DELETE_POST_MUTATION = gql("""
  mutation(\$post_id: Float!) {
    deletePost(id: \$post_id){
      id
    }
  }
""");

final DocumentNode GET_POST_MENTIONS_QUERY = gql("""
  query(\$user_id: Float!, \$filters: IFilters!) {
	getPostMentions(user_id: \$user_id, filters: \$filters) {
		meta {
			page
			per_page
			total
			previus_page
			next_page
		}
		data {
			id
			text
			published
			is_liked
			medias {
				url
			}
			location {
				name
			}
			mentions {
				user {
					id
					name
				}
			}
			user {
			  id
				name
				username
        avatar
        verified
			}
			_count {
				mentions
				likes
				comments
			}
		}
	}
}
""");

final DocumentNode GET_POST_MEDIA_QUERY = gql('''
  query(\$user_id: Float!, \$filters: IFilters!) {
	getPostMedias(user_id: \$user_id, filters: \$filters) {
		meta {
			page
			per_page
			total
			previus_page
			next_page
		}
		data {
			id
			text
			published
			is_liked
			medias {
				url
			}
			location {
				name
			}
			mentions {
				user {
					id
					name
				}
			}
			user {
        id
				name
				username
        avatar
        verified
			}
			_count {
				mentions
				likes
				comments
			}
		}
	}
}
''');

final DocumentNode GET_USER_POSTS_QUERY = gql("""
query(\$user_id: Float!, \$filters: IFilters!) {
	getUserPosts(filters: \$filters, user_id: \$user_id) {
		meta {
			page
			per_page
			total
			previus_page
			next_page
		}
		data {
			id
			text
			published
			is_liked
			medias {
				url
			}
			location {
				name
			}
			mentions {
				user {
					id
					name
          avatar
				}
			}
			user {
				id
				name
				username
        avatar
        verified
			}
			_count {
				mentions
				likes
				comments
			}
		}
	}
}
""");

final DocumentNode GET_POST_COMMENTS_QUERY = gql("""
  query (\$filters: IFilters!, \$post_id: Float!) {
	getCommentsPost(post_id: \$post_id, filters: \$filters){
		meta {
			next_page
			previus_page
			total
			page
		}
		data {
			id
			text
			user {
				id
				username
				avatar
				name
				verified
			}
		}
	}
}
""");

final DocumentNode COMMENT_POST_MUTATION = gql("""
  mutation (\$post_id: Float!, \$data: ICreateCommentDTO!) {
    commentPost(post_id: \$post_id, data: \$data) {
      id
      text
      user {
        id
        name
        avatar
      }
    }
  }
""");

final DocumentNode LIKE_POST_MUTATION = gql("""
  mutation(\$postId: Float!) {
    likePost(post_id: \$postId)
  }
""");

final DocumentNode CREATE_POST_MUTATION = gql("""
  mutation(\$data: ICreatePostDTO!) {
    createPost(data: \$data){
      id
      text
      published
      user {
        name
      }
    }
  }
""");

final DocumentNode GET_POSTS_QUERY = gql("""
  query(\$filters: IFilters!) {
    getPosts(filters: \$filters) {
      meta {
        page
        per_page
        total
        previus_page
        next_page
      }
      data {
        id
        text
        published
        is_liked
        medias {
          url
          type
          subtype
        }
        location {
          id
          name
        }
        mentions {
          user {
            id
            name
            avatar
          }
        }
        user {
          id
          name
          username
          avatar
          verified
        }
        _count {
          mentions
          likes
          comments
        }
      }
    }
  }
""");
