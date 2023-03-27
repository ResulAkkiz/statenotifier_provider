import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statenotifier_provider/firebase_example/model/user_model.dart';
import 'package:statenotifier_provider/firebase_example/service/firebase_db_service.dart';

class UserManager extends StateNotifier<List<UserModel>> {
  FirebaseDbService firebaseDbService = FirebaseDbService();

  UserManager(super._state) {
    debugPrint('Const metot çalıştı');
    getAllUsers();
  }

  Future<void> getAllUsers() async {
    List<UserModel> userList = await firebaseDbService.getAllUsers();

    state = List.from(userList);
  }

  Future<void> removeUser(String id) async {
    bool isSuccesfull = await firebaseDbService.removeUser(id);
    if (isSuccesfull) {
      state = state.where((user) => user.id != id).toList();
    }
  }

  Future<void> addUser(UserModel usermodel) async {
    UserModel newUser = usermodel;
    bool isSuccesfull = await firebaseDbService.addUser(newUser);
    if (isSuccesfull) {
      state = [...state, newUser];
    }
  }

  Future<void> updateUser(UserModel usermodel, bool status) async {
    UserModel newUser = usermodel;
    // List<UserModel> listUser = [];
    bool isSuccesfull = await firebaseDbService.updateUser(newUser, status);
    if (isSuccesfull) {
      state = state.map((element) {
        if (element.id == usermodel.id) {
          element.enable = status;
        }
        return element;
      }).toList();
      /* for (UserModel element in state) {
        if (element.id == usermodel.id) {
          element.enable = status;
        }
        listUser.add(element);
      } */
      // state = listUser;
    }
  }
}

final userStateProvider =
    StateNotifierProvider<UserManager, List<UserModel>>((ref) {
  debugPrint('userStateProvider çalıştı');
  return UserManager([]);
});
