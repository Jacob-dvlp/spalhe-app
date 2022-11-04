import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

final GET_SAVED_POSTS = gql(r'''
  query getSavedPosts($filters: IFilters!) {
	getSavedPosts (filters: $filters) {
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
			is_saved
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
			}
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
				medias
			}
		}
	}
}
''');

final GET_POSTS_BY_HASHTAG = gql(r'''
 query getPostsByHashtags($hashtag: String!) {
	getPostsByHashtags(hashtag: $hashtag, filters: {}) {
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
      is_saved
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
				medias
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
					verified
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
''');

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

final REPORT_POST_MUTATION = gql(r"""
 mutation reportPost($post_id: Float!) {
	reportPost(post_id: $post_id) {
		id
	}
}
""");

final SAVE_POST_MUTATION = gql(r"""
 mutation savePost($post_id: Float!) {
	savePost(id: $post_id)
}
""");

final DELETE_POST_MUTATION = gql(r"""
  mutation($post_id: Float!) {
    deletePost(id: $post_id){
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
        is_liked
        is_saved
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
          medias
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
            verified
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
        is_liked
        is_saved
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
          medias
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
            verified
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
        is_liked
        is_saved
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
          medias
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
            verified
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

final DocumentNode LIKE_POST_MUTATION = gql(r"""
  mutation($postId: Float!) {
    likePost(post_id: $postId)
  }
""");

final DocumentNode CREATE_POST_MUTATION = gql(r"""
  mutation($data: ICreatePostDTO!) {
    createPost(data: $data){
      id
    }
  }
""");

final DocumentNode GET_POSTS_QUERY = gql(r"""
  query getPosts($filters: IFilters!) {
    getPosts(filters: $filters) {
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
        is_saved
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
          medias
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
            verified
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
