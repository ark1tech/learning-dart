# Bulls and Cows Game Specification

## Overview

Bulls and Cows is a code-breaking game in which the player must guess the secret code within a limited number of attempts using feedback for each guess.

## Rules

Each round starts with a newly generated secret code. The player is then given a fixed number of attempts to guess the secret code. Should the player fail to guess the secret code in the said number of attempts, the round ends.

Each guess made by the player is given feedback–specifically in the number of bulls and cows present in the guess.

A position in the secret code is considered one of the following:

- **Bull**: if the position in both the secret code and the guess have the same character
- **Cow**: if the position in both the secret code and the guess do not have the same character, but:
  - The secret code's character is present in some other position `g` of the guess
  - Position `g` in the secret code is not considered a bull
  - Position `g` is not used by any other cow position

After each guess the player makes, the total number of bulls and total number of cows are shown. Note that which specific positions are bulls and cows in the guess is not disclosed to the player.

## Example

As an example, consider the secret code `1501` with the set of possible characters being `{0,1,2,3,4,5,6,7,8,9}`.

The guess `2111` results in the feedback `1` bull, `1` cows with breakdown as follows:

- `1` in position 1 is a cow since position 2 in the guess has `1` and position 2 is neither a bull nor used by another cow
- `5` in position 2 is neither a bull nor a cow
- `0` in position 3 is neither a bull nor a cow
- `1` in position 4 is a bull since position 4 in the guess has the same character

## Task

Your task is to make a terminal-based, multiple-round Bulls and Cows implementation in Dart based on the specifications that follow.

## Command Line Arguments

You are to submit `lab01.dart` that is executed as follows:

```bash
dart run lab01.dart <n> <rounds> <attempts> <seed> <chars>
```

The command line arguments are as follows:

- `<n>`: Length of the secret code
- `<rounds>`: Number of game rounds before program terminates
- `<attempts>`: Number of attempts the player can make
- `<seed>`: Seed used for pseudorandom number generation (explained below)
- `<chars>`: List of characters from which the secret code is made

### Constraints

The above are constrained by the following rules:

- `4 ≤ n ≤ 10`
- `1 ≤ rounds ≤ 10`
- `1 ≤ attempts ≤ 100`
- `2 ≤ len(chars) ≤ 10`
- `<seed>` must be an integer that fits in a single Dart int
- `<chars>` must not have duplicates

If any of the command line arguments are invalid, the program must terminate gracefully (i.e., not via an uncaught runtime exception) with an exit code of 150 without printing anything.

**Note**: The test cases used to check your work contain only printable ASCII characters (i.e., 32 to 126). Additionally, special shell characters such as `"` will be properly escaped for chars (i.e., no need to do any special handling for them).

The secret code and guesses are case-sensitive.

### Example Execution

```bash
dart run lab01.dart 4 2 8 150 0123456789
```

## Secret Code Generation

Recall that the secret code must be comprised of exactly `n` characters from `chars`.

Across all rounds, the program must have a single instance of `Random` with randomization seed set to `seed`.

For each Round `r`, `.nextInt(...)` must be called exactly `n` times using the same `Random` object. The argument of each `nextInt` call is the length of `chars`.

The Round `r` secret code `s_r` is defined as follows:

- `s_{r,k} = c_{x_{r,k}}`
- `x_{r,k}` is the result of the `k`th call to `.nextInt(...)` for Round `r`
- `c_i` is the `i`th character of `chars`
- `s_{r,i}` is the `i`th character of `s_r`

## I/O Format

There is no required standard output format–you are free to leave in prompts such as "Enter your guess:" in your submission. You are also free to show the player how many bulls and cows are present for each guess.

The player must enter only guesses (i.e., no inputs for their name or anything else) with exactly one guess per line of input. The line must not contain anything other than the guess itself.

If the player enters an invalid guess (e.g., contains characters not part of `chars`, has too many characters), the guess must not be counted, and the player must enter another guess. The number of attempts must stay the same when an invalid guess is made.

## Output File Format

Before exiting, the program must create a file called `lab01.log` which should contain the following:

- Secret code for each round
- Guess entered by the user for each round and attempt
- Feedback for each guess entered

The file must be formatted exactly as follows:

```
Round 1 secret code: <secret code>
Round 1, attempt 1: <guess> (<bulls>B <cows>C)
Round 1, attempt 2: <guess> (<bulls>B <cows>C)
...
Round 1, attempt k: <guess> (<bulls>B <cows>C)
Round 2 secret code: <secret code>
Round 2, attempt 1: <guess> (<bulls>B <cows>C)
Round 2, attempt 2: <guess> (<bulls>B <cows>C)
...
Round 2, attempt m: <guess> (<bulls>B <cows>C)
```

### Example Output

Using the earlier example, the guess `2111` for secret code `1501` must result in the following output lines:

```
Round 1 secret code: 1501
Round 1, attempt 1: 2111 (1B 1C)
```

Supposing the user correctly guesses the secret code in the next attempt, the following must be present in the output file:

```
Round 1 secret code: 1501
Round 1, attempt 1: 2111 (1B 1C)
Round 1, attempt 2: 1501 (4B 0C)
```
