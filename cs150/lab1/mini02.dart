// Song Recommendations

// Now that you can ask for someone's favorite dish and see if you match, you are now going to rate their taste in music! We're going to have a bit of fun, though, by rating their song recommendations randomly.

// For this exercise, do the following:

// 1. Get a user's song recommendations via user input, with each song separated by a comma.

// 2. Create a function whose input is the list of song recommendations and give each song a random rating from 0 to 10. The return value of the function should be a mapping between songs and their respective ratings.

// 3. Using the output of the previous function, categorize each song and rating as:

// -if rating is 0-4, "not my jam"
// -if rating is 5-7, "i can vibe with this"
// -if rating is 8-10, "certified bop"

// and print out the categorized songs:

// Certified bops: song 1, song 2, song 3
// I can vibe with this: song 4
// Not my jam: song 5, song 6

// 4. Get the average song rating and if it is greater than or equal to 5, print I like your taste in music!. Else, print Awww, I'm not a fan..

import 'dart:io';
import 'dart:math';

void main() {
  String? songRecoInput = stdin.readLineSync();
  if (songRecoInput == null) {
    exit(1);
  }

  List<String> notJam = [];
  List<String> vibeBops = [];
  List<String> certiBops = [];
  int sumRating = 0;
  double aveRating;

  List<String> songRecoList = songRecoInput.split(",");
  for (int songIndex = 0; songIndex < songRecoList.length; songIndex++) {
    int rating = Random().nextInt(11);
    sumRating += rating;
    if (0 <= rating && rating <= 4) {
      notJam.add("song $songIndex");
    } else if (5 <= rating && rating <= 7) {
      vibeBops.add("song $songIndex");
    } else {
      // 8-10 rating
      certiBops.add("song $songIndex");
    }
  }
  aveRating = (sumRating / songRecoList.length);
  if (aveRating >= 5) {
    print("I like your taste in music!");
    return;
  }
  print("Awww, I'm not a fan..");
}
