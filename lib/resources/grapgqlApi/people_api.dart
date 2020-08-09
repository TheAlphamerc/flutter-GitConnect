// part of 'graphql_query_api.dart';

class PeopleApi {
  static const String followers = r'''query userInfo($login: String!) {
    user(login: $login) {
      followers(first: 30) {
        totalCount
        nodes {
          avatarUrl
          login
          name
          url
          bio
        }
      }
    }
  }
  ''';

  static const String following = r'''query userInfo($login: String!) {
    user(login: $login) {
      following(first: 30) {
        totalCount
        nodes {
          avatarUrl
          login
          name
          url
          bio
        }
      }
    }
  }

''';
}