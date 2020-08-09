import 'package:equatable/equatable.dart';
import 'dart:convert';

class PeopleModel extends Equatable {
  final int id;
  final String name;

  PeopleModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

}

class PeopleResponse {
    PeopleResponse({
        this.data,
    });

    final Data data;

    factory PeopleResponse.fromRawJson(String str) => PeopleResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PeopleResponse.fromJson(Map<String, dynamic> json) => PeopleResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.user,
    });

    final User user;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        this.followers,
        this.following
    });

    final Followers followers;
    final Following following;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        followers: json["followers"] == null ? null : Followers.fromJson(json["followers"]),
        following: json["following"] == null ? null : Following.fromJson(json["following"]),
    );

    Map<String, dynamic> toJson() => {
        "followers": followers == null ? null : followers.toJson(),
        "following": following == null ? null : following.toJson(),
    };
}

class Followers {
    Followers({
        this.totalCount,
        this.nodes,
    });

    final int totalCount;
    final List<Node> nodes;

    factory Followers.fromRawJson(String str) => Followers.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        nodes: json["nodes"] == null ? null : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "nodes": nodes == null ? null : List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}

class Following {
    Following({
        this.totalCount,
        this.nodes,
    });

    final int totalCount;
    final List<Node> nodes;

    factory Following.fromRawJson(String str) => Following.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Following.fromJson(Map<String, dynamic> json) => Following(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        nodes: json["nodes"] == null ? null : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "nodes": nodes == null ? null : List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}

class Node {
    Node({
        this.avatarUrl,
        this.login,
        this.name,
        this.url,
        this.bio
    });

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
}

enum PeopleType{
  Follower,
  Following
}