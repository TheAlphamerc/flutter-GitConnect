import 'dart:convert';

import 'package:flutter_github_connect/model/page_info_model.dart';

class UserPullRequestResponse {
  UserPullRequestResponse({
    this.user,
  });

  final _User user;

  factory UserPullRequestResponse.fromRawJson(String str) =>
      UserPullRequestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPullRequestResponse.fromJson(Map<String, dynamic> json) =>
      UserPullRequestResponse(
        user: json["user"] == null ? null : _User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
      };
}

class _User {
  _User({
    this.login,
    this.pullRequests,
  });

  final String login;
  final UserPullRequests pullRequests;

  factory _User.fromRawJson(String str) => _User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _User.fromJson(Map<String, dynamic> json) => _User(
        login: json["login"] == null ? null : json["login"],
        pullRequests: json["pullRequests"] == null
            ? null
            : UserPullRequests.fromJson(json["pullRequests"]),
      );

  Map<String, dynamic> toJson() => {
        "login": login == null ? null : login,
        "pullRequests": pullRequests == null ? null : pullRequests.toJson(),
      };
}

class UserPullRequests {
  UserPullRequests({
    this.nodes,
    this.totalCount,
    this.pageInfo
  });

  final List<Node> nodes;
  final int totalCount;
  PageInfo pageInfo;
  factory UserPullRequests.fromRawJson(String str) =>
      UserPullRequests.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPullRequests.fromJson(Map<String, dynamic> json) =>
      UserPullRequests(
        nodes: json["nodes"] == null
            ? null
            : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        pageInfo:PageInfo.fromJson(json["pageInfo"])
      );

  Map<String, dynamic> toJson() => {
        "nodes": nodes == null
            ? null
            : List<dynamic>.from(nodes.map((x) => x.toJson())),
        "totalCount": totalCount == null ? null : totalCount,
        "pageInfo":pageInfo == null ? null : pageInfo.toJson()
      };
}

class Node {
  Node({
    this.closed,
    this.title,
    this.author,
    this.repository,
    this.viewerDidAuthor,
    this.state,
    this.closedAt,
    this.createdAt,
    this.deletions,
    this.files,
    this.number,
    this.url,
    this.type
  });
  final String url;
  final bool closed;
  final String title;
  final _Author author;
  final _Repository repository;
  final bool viewerDidAuthor;
  final PullRequestState state;
  final DateTime closedAt;
  final DateTime createdAt;
  final int deletions;
  final _Files files;
  final int number;
  /// Type is used for identify type of search pull request
  final String type;

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        type: json["__typename"] == null ? null : json["__typename"],
        url: json["url"] == null ? null : json["url"],
        closed: json["closed"] == null ? null : json["closed"],
        title: json["title"] == null ? null : json["title"],
        author:
            json["author"] == null ? null : _Author.fromJson(json["author"]),
        repository: json["repository"] == null
            ? null
            : _Repository.fromJson(json["repository"]),
        viewerDidAuthor:
            json["viewerDidAuthor"] == null ? null : json["viewerDidAuthor"],
        state: json["state"] == null ? null : stateValues.map[json["state"]],
        closedAt:
            json["closedAt"] == null ? null : DateTime.parse(json["closedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletions: json["deletions"] == null ? null : json["deletions"],
        files: json["files"] == null ? null : _Files.fromJson(json["files"]),
        number: json["number"] == null ? null : json["number"]
      );

  Map<String, dynamic> toJson() => {
        "__typename": type == null ? null : type,
        "url": url == null ? null : url,
        "closed": closed == null ? null : closed,
        "title": title == null ? null : title,
        "author": author == null ? null : author.toJson(),
        "repository": repository == null ? null : repository.toJson(),
        "viewerDidAuthor": viewerDidAuthor == null ? null : viewerDidAuthor,
        "state": state == null ? null : stateValues.reverse[state],
        "closedAt": closedAt == null ? null : closedAt.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "deletions": deletions == null ? null : deletions,
        "files": files == null ? null : files.toJson(),
        "number": number == null ? null : number,
      };
  String getPullRequestState(){
    switch (state) {
      case PullRequestState.OPEN: return "open";
      case PullRequestState.CLOSED: return "closed";
      case PullRequestState.MERGED: return "merged";
        
      default: return "Unknown";
    }
  }
}

class _Author {
  _Author({
    this.login,
    this.avatarUrl,
    this.url,
  });

  final String login;
  final String avatarUrl;
  final String url;

  factory _Author.fromRawJson(String str) => _Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _Author.fromJson(Map<String, dynamic> json) => _Author(
        login: json["login"] == null ? null : json["login"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login == null ? null : login,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "url": url == null ? null : url,
      };
}

class _Files {
  _Files({
    this.totalCount,
  });

  final int totalCount;

  factory _Files.fromRawJson(String str) => _Files.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _Files.fromJson(Map<String, dynamic> json) => _Files(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
      };
}

class _Repository {
  _Repository({
    this.nameWithOwner,
  });

  final String nameWithOwner;

  factory _Repository.fromRawJson(String str) =>
      _Repository.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _Repository.fromJson(Map<String, dynamic> json) => _Repository(
        nameWithOwner:
            json["nameWithOwner"] == null ? null : json["nameWithOwner"],
      );

  Map<String, dynamic> toJson() => {
        "nameWithOwner": nameWithOwner == null ? null : nameWithOwner,
      };
}

enum PullRequestState { OPEN, CLOSED, MERGED }

final stateValues = EnumValues({
  "MERGED": PullRequestState.MERGED,
  "CLOSED": PullRequestState.CLOSED,
  "OPEN": PullRequestState.OPEN,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
