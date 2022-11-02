import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final GET_POST_LIKES_QUERY = gql(r'''
query getPostLikes($id: Float!) {
	getPostLikes(post_id: $id) {
		id
		user {
			id
			name
      username
			avatar
		}
	}
}
''');

final GET_HASHTAGS = gql(r'''
  query getHashtags {
    getHashtags {
      id
      hashtag
      _count {
        hashtags_on_post
      }
      created_at
      updated_at
    }
  }
''');

final DELETE_POST_MUTATION = gql("""
  mutation(\$post_id: Float!) {
    deletePost(id: \$post_id){
      id
    }
  }
""");

final DocumentNode GET_POST_MENTIONS_QUERY = gql(r"""
  query($user_id: Float!, $filters: IFilters!) {
	getPostMentions(user_id: $user_id, filters: $filters) {
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

final GET_POST_MEDIA_QUERY = gql(r'''
  query($user_id: Float!, $filters: IFilters!) {
	getPostMedias(user_id: $user_id, filters: $filters) {
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

final GET_USER_POSTS_QUERY = gql(r"""
query($user_id: Float!, $filters: IFilters!) {
	getUserPosts(filters: $filters, user_id: $user_id) {
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
        is_liked
        created_at
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
          reposts
        }
        repost {
          id
          text
          created_at
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
          }
          _count {
            mentions
            likes
            comments
            reposts
            medias
          }
        }
      }
    }
  }
""");
