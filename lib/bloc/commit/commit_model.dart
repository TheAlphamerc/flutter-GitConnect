import 'dart:convert';

import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/model/page_info_model.dart';

class CommitsResponseModel {
  CommitsResponseModel({
    this.data,
  });

  final Data data;

  factory CommitsResponseModel.fromRawJson(String str) =>
      CommitsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommitsResponseModel.fromJson(Map<String, dynamic> json) =>
      CommitsResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.repository,
  });

  final Repository repository;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        repository: json["repository"] == null
            ? null
            : Repository.fromJson(json["repository"]),
      );

  Map<String, dynamic> toJson() => {
        "repository": repository == null ? null : repository.toJson(),
      };
}

class Repository {
  Repository({
    this.ref,
  });

  final Ref ref;

  factory Repository.fromRawJson(String str) =>
      Repository.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        ref: json["ref"] == null ? null : Ref.fromJson(json["ref"]),
      );

  Map<String, dynamic> toJson() => {
        "ref": ref == null ? null : ref.toJson(),
      };
}

class Ref {
  Ref({
    this.target,
  });

  final Target target;

  factory Ref.fromRawJson(String str) => Ref.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ref.fromJson(Map<String, dynamic> json) => Ref(
        target: json["target"] == null ? null : Target.fromJson(json["target"]),
      );

  Map<String, dynamic> toJson() => {
        "target": target == null ? null : target.toJson(),
      };
}

class Target {
  Target({
    this.id,
    this.history,
  });

  final String id;
  final History history;

  factory Target.fromRawJson(String str) => Target.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        id: json["id"] == null ? null : json["id"],
        history:
            json["history"] == null ? null : History.fromJson(json["history"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "history": history == null ? null : history.toJson(),
      };
}

class History {
  History({
    this.pageInfo,
    this.edges,
  });

  PageInfo pageInfo;
  final List<Edge> edges;

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
        pageInfo: json["pageInfo"] == null
            ? null
            : PageInfo.fromJson(json["pageInfo"]),
        edges: json["edges"] == null
            ? null
            : List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageInfo": pageInfo == null ? null : pageInfo.toJson(),
        "edges": edges == null
            ? null
            : List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class Edge {
  Edge({
    this.node,
  });

  final Node node;

  factory Edge.fromRawJson(String str) => Edge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : Node.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node == null ? null : node.toJson(),
      };
}

class Node {
  Node({
    this.messageHeadline,
    this.oid,
    this.message,
    this.additions,
    this.deletions,
    this.messageBody,
    this.committedDate,
    this.author,
    this.url
  });

  final String messageHeadline;
  final String oid;
  final String message;
  final int additions;
  final int deletions;
  final String messageBody;
  final DateTime committedDate;
  final Author author;
  final String url;

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        messageHeadline:
            json["messageHeadline"] == null ? null : json["messageHeadline"],
        oid: json["oid"] == null ? null : json["oid"],
        message: json["message"] == null ? null : json["message"],
        additions: json["additions"] == null ? null : json["additions"],
        deletions: json["deletions"] == null ? null : json["deletions"],
        messageBody: json["messageBody"] == null ? null : json["messageBody"],
        committedDate: json["committedDate"] == null
            ? null
            : DateTime.parse(json["committedDate"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "messageHeadline": messageHeadline == null ? null : messageHeadline,
        "oid": oid == null ? null : oid,
        "message": message == null ? null : message,
        "additions": additions == null ? null : additions,
        "deletions": deletions == null ? null : deletions,
        "messageBody": messageBody == null ? null : messageBody,
        "committedDate":
            committedDate == null ? null : committedDate.toIso8601String(),
        "author": author == null ? null : author.toJson(),
        "url": url == null ? null : url,
      };
}

class Author {
  Author({
    this.user,
    this.date,
  });

  final UserModel user;
  final DateTime date;

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
        "date": date == null ? null : date.toIso8601String(),
      };
}

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
