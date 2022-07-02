import 'package:gql/src/ast/ast.dart';
import 'package:graphql/client.dart';

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
