import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statenotifier_provider/counter_example/all_providers.dart';
import 'package:statenotifier_provider/extensions/random_string_generator.dart';
import 'package:statenotifier_provider/firebase_example/user_listview.dart';
import 'package:statenotifier_provider/firebase_example/user_manager.dart';

import 'firebase_example/model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          debugPrint('floatingActionButton build oldu');
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      await ref.read(userStateProvider.notifier).addUser(
                          UserModel(
                              id: getRandomString(12),
                              name: 'Resul+${getRandomString(2)}',
                              enable: true));
                    },
                  );
                },
              ),
              const SizedBox(
                width: 15,
              ),
              FloatingActionButton(
                child: const Icon(Icons.exposure_minus_1_rounded),
                onPressed: () async {
                  await ref
                      .read(userStateProvider.notifier)
                      .removeUser('Kyc1kHtEicGa');
                },
              ),
            ],
          );
        },
      ),
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final title = ref.watch<String>(titleProvider);
            return Text(title);
          },
        ),
      ),
      body: const UserListView(),
    );
  }
}

class HomepageBody extends ConsumerWidget {
  const HomepageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('HomepageBody build oldu');
    final counterValue = ref.watch(counterNotifierProvider);
    return Center(
      child: Text(counterValue.counter.toString()),
    );
  }
}
