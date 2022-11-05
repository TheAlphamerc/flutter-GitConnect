import 'dart:convert';

class AccessModel {
  String accessToken;
  String expiresIn;
  String refreshToken;
  String refreshTokenExpiresIn;
  String scope;
  String tokenType;

  AccessModel(
      {this.accessToken,
      this.expiresIn,
      this.refreshToken,
      this.refreshTokenExpiresIn,
      this.scope,
      this.tokenType});

  AccessModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    refreshTokenExpiresIn = json['refresh_token_expires_in'];
    scope = json['scope'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['refresh_token_expires_in'] = this.refreshTokenExpiresIn;
    data['scope'] = this.scope;
    data['token_type'] = this.tokenType;
    return data;
  }

  factory AccessModel.fromRawJson(String str) {
    Match reg1 = RegExp(r'(?=access_token).*(?=&expires_in)').firstMatch(str);
    final accessToken = reg1.group(0).split("=")[1];
    print(accessToken);

    Match reg2 =
        RegExp(r'(?=expires_in=).*(?=&refresh_token=)').firstMatch(str);
    final expiresIn = reg2.group(0).split("=")[1];
    print(expiresIn);

    Match reg3 = RegExp(r'(?=refresh_token=).*(?=&refresh_token_expires_in=)')
        .firstMatch(str);
    final refreshToken = reg3.group(0).split("=")[1];

    return AccessModel(
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken);
  }
}
