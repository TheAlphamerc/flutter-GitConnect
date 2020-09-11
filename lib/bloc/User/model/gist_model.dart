// To parse this JSON data, do
//
//     final gistResponse = gistResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_github_connect/model/page_info_model.dart';

// class GistResponse {
//     GistResponse({
//         this.data,
//     });

//     final Data data;

//     factory GistResponse.fromRawJson(String str) => GistResponse.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory GistResponse.fromJson(Map<String, dynamic> json) => GistResponse(
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data == null ? null : data.toJson(),
//     };
// }

class GistResponse {
    GistResponse({
        this.user,
    });

    final User user;

    factory GistResponse.fromRawJson(String str) => GistResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GistResponse.fromJson(Map<String, dynamic> json) => GistResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        this.gists,
    });

    final Gists gists;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        gists: json["gists"] == null ? null : Gists.fromJson(json["gists"]),
    );

    Map<String, dynamic> toJson() => {
        "gists": gists == null ? null : gists.toJson(),
    };
}

class Gists {
    Gists({
        this.totalCount,
        this.nodes,
        this.pageInfo
    });

    final int totalCount;
    final List<Node> nodes;
    PageInfo pageInfo;
    factory Gists.fromRawJson(String str) => Gists.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Gists.fromJson(Map<String, dynamic> json) => Gists(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        nodes: json["nodes"] == null ? null : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
        pageInfo : json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "nodes": nodes == null ? null : List<dynamic>.from(nodes.map((x) => x.toJson())),
        "pageInfo": pageInfo == null ? null : pageInfo.toJson()
    };
}

class Node {
    Node({
        this.owner,
        this.files,
        this.description,
        this.createdAt,
        this.isFork,
        this.isPublic,
        this.name,
        this.stargazers,
        this.updatedAt,
        this.pushedAt,
    });

    final Owner owner;
    final List<FileElement> files;
    final String description;
    final DateTime createdAt;
    final bool isFork;
    final bool isPublic;
    final String name;
    final Stargazers stargazers;
    final DateTime updatedAt;
    final DateTime pushedAt;

    factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Node.fromJson(Map<String, dynamic> json) => Node(
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        description: json["description"] == null ? null : json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        isFork: json["isFork"] == null ? null : json["isFork"],
        isPublic: json["isPublic"] == null ? null : json["isPublic"],
        name: json["name"] == null ? null : json["name"],
        stargazers: json["stargazers"] == null ? null : Stargazers.fromJson(json["stargazers"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        pushedAt: json["pushedAt"] == null ? null : DateTime.parse(json["pushedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "owner": owner == null ? null : owner.toJson(),
        "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
        "description": description == null ? null : description,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "isFork": isFork == null ? null : isFork,
        "isPublic": isPublic == null ? null : isPublic,
        "name": name == null ? null : name,
        "stargazers": stargazers == null ? null : stargazers.toJson(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "pushedAt": pushedAt == null ? null : pushedAt.toIso8601String(),
    };
}

class FileElement {
    FileElement({
        this.name,
        this.extension,
    });

    final String name;
    final String extension;

    factory FileElement.fromRawJson(String str) => FileElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        name: json["name"] == null ? null : json["name"],
        extension: json["extension"] == null ? null : json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "extension": extension == null ? null : extension,
    };
}

class Owner {
    Owner({
        this.login,
        this.avatarUrl,
    });

    final String login;
    final String avatarUrl;

    factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"] == null ? null : json["login"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    );

    Map<String, dynamic> toJson() => {
        "login": login == null ? null :login,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
    };
}


class Stargazers {
    Stargazers({
        this.totalCount,
    });

    final int totalCount;

    factory Stargazers.fromRawJson(String str) => Stargazers.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Stargazers.fromJson(Map<String, dynamic> json) => Stargazers(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
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
