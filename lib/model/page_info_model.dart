import 'dart:convert';
class PageInfo {
    PageInfo({
        this.endCursor,
        this.hasNextPage,
    });

    final String endCursor;
    final bool hasNextPage;

    factory PageInfo.fromRawJson(String str) => PageInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        endCursor: json["endCursor"] == null ? null : json["endCursor"],
        hasNextPage: json["hasNextPage"] == null ? null : json["hasNextPage"],
    );

    Map<String, dynamic> toJson() => {
        "endCursor": endCursor == null ? null : endCursor,
        "hasNextPage": hasNextPage == null ? null : hasNextPage,
    };
}