// Favorite Dish

// The way to a person's heart is through their stomach, or so they say. So let's first see if a potential match has the same favorite dish as you (very important).

// Your task is to create a simple Dart program that has a string variable whose value is your favorite dish, and make it ask a user to input their favorite dish. If your and the user's favorite dishes match, print out I like [insert dish here] too!. If not, print Awww, too bad..

// Matching between the user input and the favorite dish variable should be case insensitive, so HOTDOG and hotdog and even HoTdOg should match.

import 'dart:io';

void main() {
  String? dishInput = stdin.readLineSync();
  if (dishInput == null) {
    exit(1);
  }
  List<String> favoriteDishes = ['adobo', 'nilaga', 'cake'];
  String dishInputLowCase = dishInput.toLowerCase();
  if (favoriteDishes.contains(dishInputLowCase)) {
    print("I like $dishInputLowCase too!");
    return;
  }
  print("Aww, too bad..");
}
