import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:statenotifier_provider/firebase_example/model/user_model.dart';

class FirebaseDbService {
  FirebaseFirestore firebaseService = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseService.collection('users').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> element
        in querySnapshot.docs) {
      var user = element.data();
      list.add(UserModel.fromMap(user));
    }
    return list;
  }

  Future<bool> removeUser(String id) async {
    await firebaseService.collection('users').doc(id).delete();
    return true;
  }

  Future<bool> addUser(UserModel usermodel) async {
    await firebaseService
        .collection('users')
        .doc(usermodel.id)
        .set(usermodel.toMap());
    return true;
  }

  Future<bool> updateUser(UserModel usermodel, bool status) async {
    bool successFull = true;
    await firebaseService
        .collection('users')
        .doc(usermodel.id)
        .update({'enable': status}).onError((error, stackTrace) {
      successFull = false;
    });
    return successFull;
  }
}
