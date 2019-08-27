part of firebase_rest_api;

class FirebaseUser implements FirebaseObject {
  FirebaseUser(this.client, this.json);

  @override
  final FirestoreClient client;

  @override
  final Map<String, dynamic> json;

  String get displayName => json['displayName'];

  String get email => json['email'];

  String get photoUrl => json['photoUrl'];

  String get uid => json['localId'];

  bool get registered => json['registered'] ?? false;

  List<ProviderInfo> get providerUserInfo {
    if (json['providerUserInfo'] == null) return null;
    return List.from(json['providerUserInfo']).map((i) {
      final _data = i as Map<String, dynamic>;
      return ProviderInfo(_data['providerId'], _data['federatedId']);
    }).toList();
  }

  bool get isAnonymous => email == null || email.isEmpty;

  bool get isEmailVerified => json['emailVerified'];

  String get passwordHash => json['passwordHash'];

  double get passwordUpdatedAt => json['passwordUpdatedAt'];

  DateTime get validSince => json['validSince'];

  bool get disabled => json['disabled'];

  DateTime get lastLoginAt => json['lastLoginAt'];

  DateTime get createdAt => json['createdAt'];

  bool get customAuth => json['customAuth'];

  Future editInfo({String displayName, String photoUrl}) {
    return client.updateProfileForUser(
      client.token.idToken,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  Future unlinkProviders(List<String> providers) {
    return client.unlinkProvidersForUser(client.token.idToken, providers);
  }

  Future<String> sendEmailVerification() {
    return client.sendEmailVerificationForUser(client.token.idToken);
  }

  Future changePassword(String password) {
    return client.changePasswordForUser(client.token.idToken, password);
  }

  Future changeEmail(String email) {
    return client.changeEmailForUser(client.token.idToken, email);
  }

  Future<FirebaseUser> getInfo() {
    return client.getCurrentUser(client.token.idToken);
  }
}

class ProviderInfo {
  ProviderInfo(this.providerId, this.federatedId);

  final String providerId, federatedId;
}
