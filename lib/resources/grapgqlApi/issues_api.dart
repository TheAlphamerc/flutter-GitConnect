// part of 'graphql_query_api.dart';

class IssuesApis {
  static const String issues1 = r'''{
    viewer {
      issues(first: 30, orderBy: {field: CREATED_AT, direction: DESC}) {
        totalCount
        nodes {
          title
          createdAt
          state
          number
          viewerDidAuthor
          closed
          authorAssociation
          author {
            login
            avatarUrl
            url
          }
          repository {
            name
            url
            owner {
              login
              avatarUrl
            }
          }
          labels(first: 10) {
            nodes {
              color
              name
            }
          }
         
        }
      }
    }
  }
''';

  static const String issues= r'''query userInfo($login: String!) {
    user(login: $login) {
      issues(first: 30, orderBy: {field: CREATED_AT, direction: DESC}) {
        totalCount
        nodes {
          title
          createdAt
          state
          number
          viewerDidAuthor
          closed
          authorAssociation
          author {
            login
            avatarUrl
            url
          }
          repository {
            name
            url
            owner {
              login
              avatarUrl
            }
          }
          labels(first: 10) {
            nodes {
              color
              name
            }
          }
        }
      }
    }
  }
''';
}