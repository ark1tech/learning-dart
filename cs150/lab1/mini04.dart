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
import 'dart:math';

class LovePoem {
  final List<String> flowers;
  final List<String> colors;
  final List<String> nouns;
  final List<String> adjectives;

  const LovePoem({
    required this.flowers,
    required this.colors,
    required this.nouns,
    required this.adjectives,
  });

  void Generate(int stanzas, File outputFile) {
    var outputSink = outputFile.openWrite(mode: FileMode.append);
    for (int i = 0; i < stanzas; i++) {
      outputSink.write(
        "${flowers[Random().nextInt(flowers.length)]} are ${colors[Random().nextInt(colors.length)]}\n",
      );
      outputSink.write(
        "${flowers[Random().nextInt(flowers.length)]} are ${colors[Random().nextInt(colors.length)]}\n",
      );
      outputSink.write(
        "${nouns[Random().nextInt(nouns.length)]} is ${adjectives[Random().nextInt(adjectives.length)]}\n",
      );
      outputSink.write("and so are you\n\n");
    }
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

int getStanzas() {
  try {
    print("How many stanzas?");
    String? inputStanzas = stdin.readLineSync();
    if (inputStanzas == null) {
      throw FormatException();
    }
    int stanzas = int.parse(inputStanzas);
    return stanzas;
  } catch (e) {
    print("Error: $e");
    exit(1);
  }
}

void main(List<String> args) async {
  checkArgs(args);

  final inputFile = File('${args[0]}');
  final outputFile = File('${args[1]}');

  int stanzas = getStanzas();

  final categoryMap = <String, List<String>>{};
  final lineRegex = RegExp(r'^(?<name>\w+):\s{1}(?<list>\[.*\])$');
  const requiredKeys = ['flowers', 'colors', 'nouns', 'adjectives'];

  final lines = inputFile
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  await for (final line in lines) {
    final match = lineRegex.firstMatch(line.trim());
    if (match == null) {
      exit(1);
    }

    final name = match.namedGroup('name')!;
    final listContent = match
        .namedGroup('list')!
        .replaceAll(RegExp(r'[\[\]]'), '')
        .split(',')
        .map((s) => s.trim())
        .toList();

    if (!requiredKeys.contains(name)) {
      print("Error: make sure format is correct in the input.txt file");
      exit(1);
    }

    categoryMap[name] = listContent;
  }

  final poem = LovePoem(
    flowers: categoryMap['flowers'] ?? [''],
    colors: categoryMap['colors'] ?? [''],
    nouns: categoryMap['nouns'] ?? [''],
    adjectives: categoryMap['adjectives'] ?? [''],
  );

  poem.Generate(stanzas, outputFile);
}
