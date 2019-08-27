part of firebase_rest_api;

abstract class FirestoreAccessToken {
  
  String get refreshToken;

  DateTime get createdAt;

  DateTime get expiresAt;

  String get displayName;

  String get email;

  String get kind;

  int get expiresInSeconds;

  String get idToken;

  String get localId;

  bool get emailVerified;

  bool get isExpired => expiresAt.isAfter(new DateTime.now());
}

class FirestoreJsonAccessToken extends FirestoreAccessToken {
  FirestoreJsonAccessToken(this.json, this.createdAt);

  final Map<String, dynamic> json;

  @override
  String get refreshToken => json["refresh_token"];

  @override
  final DateTime createdAt;

  @override
  DateTime get expiresAt =>
      createdAt.add(new Duration(seconds: expiresInSeconds));

  @override
  String get displayName => json['displayName'] as String;

  @override
  String get email => json['email'] as String;

  @override
  String get kind => json['kind'] as String;

  @override
  String get idToken => json['idToken'];

  @override
  String get localId => json['localId'] as String;

  @override
  int get expiresInSeconds => int.tryParse(json["expiresIn"]);

  @override
  bool get emailVerified => json['emailVerified'];
}
