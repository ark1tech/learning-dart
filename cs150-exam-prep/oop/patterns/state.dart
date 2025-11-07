/// State Design Pattern
/// Allows an object to alter its behavior when its internal state changes
/// The object will appear to change its class

// Example 1: Traffic Light System
abstract class TrafficLightState {
  void handle(TrafficLight context);
  String getColor();
}

class RedLight implements TrafficLightState {
  @override
  void handle(TrafficLight context) {
    print('🔴 Red Light - STOP');
    print('Switching to Green...');
    context.setState(GreenLight());
  }

  @override
  String getColor() => 'RED';
}

class YellowLight implements TrafficLightState {
  @override
  void handle(TrafficLight context) {
    print('🟡 Yellow Light - SLOW DOWN');
    print('Switching to Red...');
    context.setState(RedLight());
  }

  @override
  String getColor() => 'YELLOW';
}

class GreenLight implements TrafficLightState {
  @override
  void handle(TrafficLight context) {
    print('🟢 Green Light - GO');
    print('Switching to Yellow...');
    context.setState(YellowLight());
  }

  @override
  String getColor() => 'GREEN';
}

class TrafficLight {
  TrafficLightState _state;

  TrafficLight(this._state);

  void setState(TrafficLightState state) {
    _state = state;
  }

  void change() {
    _state.handle(this);
  }

  String getCurrentColor() => _state.getColor();
}

// Example 2: Document Workflow
abstract class DocumentState {
  void publish(Document doc);
  void review(Document doc);
  void reject(Document doc);
  String getStatus();
}

class DraftState implements DocumentState {
  @override
  String getStatus() => 'Draft';

  @override
  void publish(Document doc) {
    print('Cannot publish draft directly. Must be reviewed first.');
  }

  @override
  void review(Document doc) {
    print('📝 Draft submitted for review');
    doc.setState(ReviewState());
  }

  @override
  void reject(Document doc) {
    print('Cannot reject a draft');
  }
}

class ReviewState implements DocumentState {
  @override
  String getStatus() => 'Under Review';

  @override
  void publish(Document doc) {
    print('✅ Review approved - Publishing document');
    doc.setState(PublishedState());
  }

  @override
  void review(Document doc) {
    print('Already under review');
  }

  @override
  void reject(Document doc) {
    print('❌ Review rejected - Sending back to draft');
    doc.setState(DraftState());
  }
}

class PublishedState implements DocumentState {
  @override
  String getStatus() => 'Published';

  @override
  void publish(Document doc) {
    print('Already published');
  }

  @override
  void review(Document doc) {
    print('Published documents cannot be reviewed');
  }

  @override
  void reject(Document doc) {
    print('Published documents cannot be rejected');
  }
}

class Document {
  final String title;
  DocumentState _state;

  Document(this.title) : _state = DraftState();

  void setState(DocumentState state) {
    _state = state;
  }

  void submitForReview() {
    _state.review(this);
  }

  void publish() {
    _state.publish(this);
  }

  void reject() {
    _state.reject(this);
  }

  String getStatus() => _state.getStatus();

  void printStatus() {
    print('Document "$title" is ${getStatus()}');
  }
}

// Example 3: Player States (Game)
abstract class PlayerState {
  void pressPlay(MediaPlayer player);
  void pressPause(MediaPlayer player);
  void pressStop(MediaPlayer player);
  String getState();
}

class StoppedState implements PlayerState {
  @override
  String getState() => 'Stopped';

  @override
  void pressPlay(MediaPlayer player) {
    print('▶️  Starting playback...');
    player.setState(PlayingState());
  }

  @override
  void pressPause(MediaPlayer player) {
    print('Already stopped');
  }

  @override
  void pressStop(MediaPlayer player) {
    print('Already stopped');
  }
}

class PlayingState implements PlayerState {
  @override
  String getState() => 'Playing';

  @override
  void pressPlay(MediaPlayer player) {
    print('Already playing');
  }

  @override
  void pressPause(MediaPlayer player) {
    print('⏸️  Pausing playback...');
    player.setState(PausedState());
  }

  @override
  void pressStop(MediaPlayer player) {
    print('⏹️  Stopping playback...');
    player.setState(StoppedState());
  }
}

class PausedState implements PlayerState {
  @override
  String getState() => 'Paused';

  @override
  void pressPlay(MediaPlayer player) {
    print('▶️  Resuming playback...');
    player.setState(PlayingState());
  }

  @override
  void pressPause(MediaPlayer player) {
    print('Already paused');
  }

  @override
  void pressStop(MediaPlayer player) {
    print('⏹️  Stopping playback...');
    player.setState(StoppedState());
  }
}

class MediaPlayer {
  String trackName;
  PlayerState _state;

  MediaPlayer(this.trackName) : _state = StoppedState();

  void setState(PlayerState state) {
    _state = state;
  }

  void play() {
    _state.pressPlay(this);
    if (_state is PlayingState) {
      print('🎵 Now playing: $trackName');
    }
  }

  void pause() {
    _state.pressPause(this);
  }

  void stop() {
    _state.pressStop(this);
  }

  String getState() => _state.getState();
}

// Example 4: ATM Machine States
abstract class ATMState {
  void insertCard(ATM atm);
  void ejectCard(ATM atm);
  void enterPin(ATM atm, String pin);
  void withdrawCash(ATM atm, double amount);
}

class NoCardState implements ATMState {
  @override
  void insertCard(ATM atm) {
    print('💳 Card inserted');
    atm.setState(HasCardState());
  }

  @override
  void ejectCard(ATM atm) {
    print('No card to eject');
  }

  @override
  void enterPin(ATM atm, String pin) {
    print('Please insert card first');
  }

  @override
  void withdrawCash(ATM atm, double amount) {
    print('Please insert card first');
  }
}

class HasCardState implements ATMState {
  @override
  void insertCard(ATM atm) {
    print('Card already inserted');
  }

  @override
  void ejectCard(ATM atm) {
    print('💳 Card ejected');
    atm.setState(NoCardState());
  }

  @override
  void enterPin(ATM atm, String pin) {
    if (pin == '1234') {
      print('✅ PIN correct');
      atm.setState(AuthenticatedState());
    } else {
      print('❌ Wrong PIN');
      ejectCard(atm);
    }
  }

  @override
  void withdrawCash(ATM atm, double amount) {
    print('Please enter PIN first');
  }
}

class AuthenticatedState implements ATMState {
  @override
  void insertCard(ATM atm) {
    print('Card already inserted');
  }

  @override
  void ejectCard(ATM atm) {
    print('💳 Card ejected');
    atm.setState(NoCardState());
  }

  @override
  void enterPin(ATM atm, String pin) {
    print('Already authenticated');
  }

  @override
  void withdrawCash(ATM atm, double amount) {
    if (atm.balance >= amount) {
      atm.balance -= amount;
      print('💵 Dispensing \$$amount');
      print('💰 Remaining balance: \$${atm.balance}');
      ejectCard(atm);
    } else {
      print('❌ Insufficient funds');
      ejectCard(atm);
    }
  }
}

class ATM {
  ATMState _state;
  double balance = 1000.0;

  ATM() : _state = NoCardState();

  void setState(ATMState state) {
    _state = state;
  }

  void insertCard() => _state.insertCard(this);
  void ejectCard() => _state.ejectCard(this);
  void enterPin(String pin) => _state.enterPin(this, pin);
  void withdraw(double amount) => _state.withdrawCash(this, amount);
}

// Main demonstration
void main() {
  print('=== State Pattern Examples ===\n');

  // Example 1: Traffic Light
  print('--- Example 1: Traffic Light ---');
  var trafficLight = TrafficLight(RedLight());

  for (int i = 0; i < 4; i++) {
    trafficLight.change();
    print('');
  }

  // Example 2: Document Workflow
  print('--- Example 2: Document Workflow ---');
  var doc = Document('Quarterly Report');

  doc.printStatus();
  doc.publish(); // Can't publish draft

  print('');
  doc.submitForReview();
  doc.printStatus();

  print('');
  doc.publish(); // Now we can publish
  doc.printStatus();

  print('');
  doc.reject(); // Can't reject published

  // Example 3: Media Player
  print('\n--- Example 3: Media Player ---');
  var player = MediaPlayer('Bohemian Rhapsody');

  player.play();
  print('State: ${player.getState()}\n');

  player.pause();
  print('State: ${player.getState()}\n');

  player.play();
  print('State: ${player.getState()}\n');

  player.stop();
  print('State: ${player.getState()}\n');

  // Example 4: ATM Machine
  print('--- Example 4: ATM Machine ---');
  var atm = ATM();

  atm.withdraw(100); // No card
  print('');

  atm.insertCard();
  atm.enterPin('0000'); // Wrong PIN
  print('');

  atm.insertCard();
  atm.enterPin('1234'); // Correct PIN
  atm.withdraw(200);
  print('');

  atm.insertCard();
  atm.enterPin('1234');
  atm.withdraw(900); // Insufficient funds

  // Key Points
  print('\n--- State Pattern Benefits ---');
  print('✓ Organizes state-specific behavior');
  print('✓ Eliminates large conditional statements');
  print('✓ Each state is a separate class');
  print('✓ Easy to add new states');
  print('✓ State transitions are explicit');
  print('✓ Single Responsibility Principle');
}

