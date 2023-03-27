import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statenotifier_provider/firebase_example/model/user_model.dart';
import 'package:statenotifier_provider/firebase_example/user_manager.dart';

class UserListView extends ConsumerWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<UserModel> users = ref.watch(userStateProvider);

    return ListView(
      children: [
        for (final user in users)
          CheckboxListTile(
            value: user.enable,
            onChanged: (value) async {
              await ref
                  .watch(userStateProvider.notifier)
                  .updateUser(user, value!);
            },
            title: Text('${user.name}  ${user.id}'),
          ),
      ],
    );
  }
}
