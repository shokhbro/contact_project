import 'package:lesson_21/models/counter.dart';

class CounterController {
  Counter counter = Counter(0);

  int get value {
    return counter.value;
  }

  void plus() {
    counter.value++;
  }

  void minus() {
    if (counter.value == 0) {
      return;
    } else {
      counter.value--;
    }
  }
}

