import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statenotifier_provider/counter_example/model/counter.dart';

class CounterManager extends StateNotifier<Counter> {
  CounterManager() : super(Counter(0));

  void increaseCounter() {
    state = Counter(++state.counter);
  }

  void decreaseCounter() {
    state = Counter(--state.counter);
  }
}
