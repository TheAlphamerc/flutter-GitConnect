import 'dart:convert';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/model/page_info_model.dart';

class User {
  User({
    this.followModel,
  });

  final FollowModel followModel;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        followModel: json["followers"] == null
            ? json["following"] == null
                ? null
                : FollowModel.fromJson(json["following"])
            : FollowModel.fromJson(json["followers"]),
      );

  Map<String, dynamic> toJson() => {
        "followers": followModel == null ? null : followModel.toJson(),
        "following": followModel == null ? null : followModel.toJson(),
      };
}

class FollowModel {
  FollowModel({this.totalCount, this.nodes, this.pageInfo});

  final int totalCount;
  final List<Node> nodes;
  PageInfo pageInfo;
  factory FollowModel.fromRawJson(String str) =>
      FollowModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        nodes: json["nodes"] == null
            ? null
            : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
        pageInfo: json["pageInfo"] == null
            ? null
            : PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "nodes": nodes == null
            ? null
            : List<dynamic>.from(nodes.map((x) => x.toJson())),
        "pageInfo": pageInfo == null ? null : pageInfo.toJson()
      };
}

class Node {
  Node({this.avatarUrl, this.login, this.name, this.url, this.bio});

  final String avatarUrl;
  final String login;
  final String name;
  final String url;
  final String bio;

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        login: json["login"] == null ? null : json["login"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        bio: json["bio"] == null ? null : json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "login": login == null ? null : login,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "bio": bio == null ? null : bio,
      };
  
  UserModel toUserModel(){
      return UserModel(
        avatarUrl: this.avatarUrl,
        login: this.login, 
        name: this.name,
        url:this.url,
        bio: this.bio,
      );
  }
}

enum PeopleType { Follower, Following }

extension TypeOfPeople on PeopleType {
  String asString() => {
        PeopleType.Follower: "Followers",
        PeopleType.Following: "Following"
      }[this];

  static PeopleType fromString(String value) => {
        'Followers': PeopleType.Follower,
        'Following': PeopleType.Following,
      }[value];
}
