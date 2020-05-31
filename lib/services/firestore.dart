import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Methods in this class are consumed by providers
class FirestoreService {
  final String uid;

  FirestoreService({@required this.uid}) : assert(uid != null);

  static final firestore = Firestore.instance;

  // Collection References
  final CollectionReference userProfilesCollection =
      firestore.collection('user-profiles');

  Future updateUserProfile(String name) {
    // TODO: This should only happen if user is signing in for the first time and his profile doesn't exist
    userProfilesCollection.document(uid).snapshots().listen((userData) async {
      if (userData.data != null) {
        await setFcmToken();
        return;
      }
      await userProfilesCollection.document(uid).setData({'name': name});
      await setFcmToken();
    });
  }

  Stream<DocumentSnapshot> get userProfile {
    return userProfilesCollection.document(uid).snapshots();
  }

  Future getUserToken() async {
    final user = await FirebaseAuth.instance.currentUser();
    return user.getIdToken()
      .then((tokenInfo) {
        return tokenInfo.token;
    });
  }


  Future<void> setFcmToken() async {
    // TODO: Ability to add multiple FCM tokens fo a user in case he changes his phone
    await userProfilesCollection
        .document(uid)
        .updateData({'fcm_token': await FirebaseMessaging().getToken()});
  }
}
