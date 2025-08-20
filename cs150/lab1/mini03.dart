// More Preference Matching

// After getting to know (and judging) someone's music taste, you just need to know a few more of their preferences to see if you truly are a match made in CS 150!

// Use command line arguments to get someone's ideal age (in years) and height (in cm) for dating, their zodiac sign, and their favorite color. The program should run like:

/* dart run lab01_3.dart 22 165 cancer green */

// Define a class called Preference that contains a person's preferences:

// age = int
// height = double
// zodiac = string
// favorite color = string

// Check whether the list of command line arguments is an empty list or if the length is not exactly 4. If it is either of those, print out an error and exit the program.

// Create two Preference objects. The first one contains the information from the command line arguments while the second contains your own preferences.

// Create a function that takes both preferences and returns a list of incompatible preferences (e.g. ['height', 'zodiac']). If the list of non-matching preferences is empty, print "It's a match!", else print "We're not meant to be :(". Compatibility is defined as such:

// age: if the ages are within 5 years of each other and neither are below 18
// height: if the heights are within 15cm of each other
// zodiac: if the two zodiacs match (this isn't really the case, but for simplicity's sake we'll stick with this)
// favorite color: if the two colors match

import 'dart:io';

class Preference {
  final int age;
  final double height;
  final String zodiac;
  final String favColor;

  const Preference({
    required this.age,
    required this.height,
    required this.zodiac,
    required this.favColor,
  });

  factory Preference.fromArgs(List<String> args) {
    try {
      if (args.length != 4) {
        throw ArgumentError('Expected exactly 4 arguments, got ${args.length}');
      }

      final age = int.parse(args[0]);
      final height = double.parse(args[1]);
      final zodiac = args[2];
      final favColor = args[3];

      return Preference(
        age: age,
        height: height,
        zodiac: zodiac,
        favColor: favColor,
      );
    } catch (e) {
      print("Error: $e");
      exit(1);
    }
  }

  @override
  String toString() {
    return 'age: $age\nheight: $height\nzodiac: $zodiac\nfavColor: $favColor';
  }
}

List<String> checkIncompatibility(Preference pref1, Preference pref2) {
  List<String> incompatiblePrefList = [];
  if (pref1.age < 18 || pref2.age < 18 || (pref1.age - pref2.age).abs() > 5) {
    incompatiblePrefList.add("age");
  }
  if ((pref1.height - pref2.height).abs() > 15) {
    incompatiblePrefList.add("height");
  }
  if (pref1.zodiac.toLowerCase() != pref2.zodiac.toLowerCase()) {
    incompatiblePrefList.add("zodiac");
  }
  if (pref1.favColor.toLowerCase() != pref2.favColor.toLowerCase()) {
    incompatiblePrefList.add("fav color");
  }

  return incompatiblePrefList;
}

void main(List<String> args) {
  Preference argsPref = Preference.fromArgs(args);
  Preference myPref = Preference(
    age: 18,
    height: 6.5,
    zodiac: "leo",
    favColor: "green",
  );
  if (checkIncompatibility(argsPref, myPref).length == 0) {
    print("It's a match!");
    return;
  }
  print("We're not meant to be :(");
}
