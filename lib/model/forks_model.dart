import 'dart:convert';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart' as gist;
import 'package:flutter_github_connect/model/page_info_model.dart';

class ForksModel {
    ForksModel({
        this.totalCount,
        this.pageInfo,
        this.nodes,
    });

    final int totalCount;
    PageInfo pageInfo;
    final List<ForksNode> nodes;

    factory ForksModel.fromRawJson(String str) => ForksModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ForksModel.fromJson(Map<String, dynamic> json) => ForksModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
        nodes: json["nodes"] == null ? null : List<ForksNode>.from(json["nodes"].map((x) => ForksNode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "pageInfo": pageInfo == null ? null : pageInfo.toJson(),
        "nodes": nodes == null ? null : List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}

class ForksNode {
    ForksNode({
        this.createdAt,
        this.forkCount,
        this.name,
        this.nameWithOwner,
        this.description,
        this.stargazers,
        this.languages,
        this.owner,
    });

    final DateTime createdAt;
    final int forkCount;
    final String name;
    final String nameWithOwner;
    final String description;
    final gist.Stargazers stargazers;
    final Languages languages;
    final Owner owner;

    factory ForksNode.fromRawJson(String str) => ForksNode.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ForksNode.fromJson(Map<String, dynamic> json) => ForksNode(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        forkCount: json["forkCount"] == null ? null : json["forkCount"],
        name: json["name"] == null ? null : json["name"],
        nameWithOwner: json["nameWithOwner"] == null ? null : json["nameWithOwner"],
        description: json["description"] == null ? null : json["description"],
        stargazers: json["stargazers"] == null ? null : gist.Stargazers.fromJson(json["stargazers"]),
        languages: json["languages"] == null ? null : Languages.fromJson(json["languages"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "forkCount": forkCount == null ? null : forkCount,
        "name": name == null ? null : name,
        "nameWithOwner": nameWithOwner == null ? null : nameWithOwner,
        "description": description == null ? null : description,
        "stargazers": stargazers == null ? null : stargazers.toJson(),
        "languages": languages == null ? null : languages.toJson(),
        "owner": owner == null ? null : owner.toJson(),
    };
}