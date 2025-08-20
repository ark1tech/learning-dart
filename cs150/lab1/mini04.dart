// Love Letter

// So you've found a potential match and you want to impress them by...writing a love poem!

// Prepare a text file that has the following lines:

// flowers: [any number of flowers(plural), separated by commas]
// colors: [any number of colors, separated by commas]
// nouns: [any number of nouns (singular), separated by commas]
// adjectives: [any number of adjectives that describe your ideal partner, separated by commas]

// Use command line arguments to get two file names: the input file from the previous step and the output file. The program should run like:

/* dart run lab01_4.dart input.txt output.txt */

// Create a class called LovePoem that has four variables flowers, colors, nouns, and adjectives, and create a new instance of that class that will store the lists of words given in the input file to their corresponding variables.

// Create a class function inside LovePoem called Generate that takes in an int denoting the number of stanzas (which should come from user input) and the output file, and writes a poem to the output file with the specified number of stanzas. The poem format is this:

// [flower] are [color]
// [flower] are [color]
// [noun]   is  [adjective]
// and so are you
// where each element is a randomly selected word from the list of strings in the LovePoem's variables.

import 'dart:io';
import 'dart:convert';
import 'dart:async';

class LovePoem {
  final String flowers;
  final String colors;
  final String nouns;
  final String adjectives;

  const LovePoem({
    required this.flowers,
    required this.colors,
    required this.nouns,
    required this.adjectives,
  });

  factory LovePoem.fromTxtFile(List<String> args) {
    final flowers = args[0];
    final colors = args[1];
    final nouns = args[2];
    final adjectives = args[3];

    return LovePoem(
      flowers: flowers,
      colors: colors,
      nouns: nouns,
      adjectives: adjectives,
    );
  }
}

void checkArgs(List<String> args) {
  try {
    if (args.length != 2) {
      throw ArgumentError('Expected exactly 4 arguments, got ${args.length}');
    }
    if (!args[0].endsWith(".txt") || !args[1].endsWith(".txt")) {
      throw ArgumentError(
        'Expected an input and output txt filem got ${args[0]} and ${args[1]}',
      );
    }
    // Check if file exists
    File('${args[0]}').exists();
  } catch (e) {
    print("Error: $e");
    exit(1);
  }
}

void main(List<String> args) async {
  checkArgs(args);

  final inputTxtFile = File('${args[0]}');
  final outputTxtFile = File('${args[1]}');

  Stream<String> inputLines = inputTxtFile
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter());

  await for (String lines in inputLines) {
    print("$lines");
  }

  // String contents = await inputTxtFile.readAsString();
  // print(contents);

  // var logSink = outputTxtFile.openWrite(mode: FileMode.append);
  // logSink.write('meow');

  // logSink.close();
}
