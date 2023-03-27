import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statenotifier_provider/counter_example/counter_manager.dart';
import 'package:statenotifier_provider/counter_example/model/counter.dart';

final titleProvider = Provider<String>((ref) => 'StateNotifierProvider');

final counterNotifierProvider =
    StateNotifierProvider<CounterManager, Counter>((ref) => CounterManager());
