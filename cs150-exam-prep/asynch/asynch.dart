/// Asynchronous Programming

Future<String> fetchUserData() async {
  print('Fetching user data...');
  await Future.delayed(Duration(seconds: 2));
  return 'User: John Doe';
}

Future<int> divideAsync(int a, int b) async {
  await Future.delayed(Duration(milliseconds: 500));
  if (b == 0) {
    throw Exception('Cannot divide by zero');
  }
  return a ~/ b;
}

Future<String> prepareBreakfast() async {
  print('Starting breakfast preparation...');

  var toast = await makeToast();
  var eggs = await cookEggs();
  var coffee = await brewCoffee();

  return '$toast, $eggs, $coffee ready!';
}

Future<String> makeToast() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Toast';
}

Future<String> cookEggs() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Eggs';
}

Future<String> brewCoffee() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Coffee';
}

// parallel operations with Future.wait
Future<void> prepareBreakfastFast() async {
  print('Starting parallel breakfast preparation...');

  var results = await Future.wait([makeToast(), cookEggs(), brewCoffee()]);

  print('All ready: ${results.join(", ")}');
}

// Stream<int> countDown(int from) async* {
//   for (int i = from; i >= 0; i--) {
//     await Future.delayed(Duration(seconds: 1));
//     yield i; // Emit value
//   }
// }

// Stream<String> getMessages() async* {
//   yield 'Hello';
//   await Future.delayed(Duration(seconds: 1));
//   yield 'How are you?';
//   await Future.delayed(Duration(seconds: 1));
//   yield 'Goodbye!';
// }

void main() async {
  var userData = await fetchUserData();
  print('$userData\n');

  try {
    var result = await divideAsync(10, 2);
    print('10 / 2 = $result');

    result = await divideAsync(10, 0);
    print('10 / 0 = $result');
  } catch (e) {
    print('Error: $e\n');
  }

  var breakfast = await prepareBreakfast();
  print('$breakfast\n');

  await prepareBreakfastFast();
  print('');

  // await for (var count in countDown(3)) {
  //   print('Count: $count');
  // }
  // print('');

  // await for (var message in getMessages()) {
  //   print('Received: $message');
  // }
}
