/// Object Composition in Dart
/// "Favor composition over inheritance"
/// Composition: Building complex objects by combining simpler ones

// Example 1: Basic Composition
// Instead of inheritance, we compose objects

// Component classes
class Engine {
  final int horsepower;
  bool isRunning = false;

  Engine(this.horsepower);

  void start() {
    isRunning = true;
    print('Engine started ($horsepower HP)');
  }

  void stop() {
    isRunning = false;
    print('Engine stopped');
  }
}

class Wheels {
  final int count;

  Wheels(this.count);

  void rotate() {
    print('$count wheels rotating');
  }
}

class Radio {
  String currentStation = 'FM 101.5';

  void play() {
    print('🎵 Playing $currentStation');
  }

  void changeStation(String station) {
    currentStation = station;
    print('Changed to $station');
  }
}

// Composed class - Car HAS-A Engine, Wheels, and Radio
class Car {
  final String brand;
  final Engine engine;
  final Wheels wheels;
  final Radio radio;

  Car(this.brand, this.engine, this.wheels, this.radio);

  void drive() {
    if (!engine.isRunning) {
      print('Cannot drive - engine is off!');
      return;
    }
    print('$brand is driving...');
    wheels.rotate();
  }

  void start() {
    engine.start();
    print('$brand is ready!');
  }

  void stop() {
    engine.stop();
    print('$brand stopped.');
  }

  void listenToMusic() {
    radio.play();
  }
}

// Example 2: Flexible Composition
// Different components can be mixed and matched

class Battery {
  int chargeLevel = 100;

  void charge() {
    chargeLevel = 100;
    print('Battery fully charged');
  }

  void use(int amount) {
    chargeLevel = (chargeLevel - amount).clamp(0, 100);
    print('Battery level: $chargeLevel%');
  }
}

class GPS {
  void navigate(String destination) {
    print('📍 Navigating to $destination');
  }
}

// Electric car with different composition
class ElectricCar {
  final String brand;
  final Battery battery;
  final Wheels wheels;
  final GPS? gps; // Optional component

  ElectricCar(this.brand, this.battery, this.wheels, {this.gps});

  void drive() {
    if (battery.chargeLevel < 10) {
      print('Low battery! Please charge.');
      return;
    }
    print('$brand electric car driving silently...');
    battery.use(5);
    wheels.rotate();
  }

  void navigateTo(String destination) {
    if (gps != null) {
      gps!.navigate(destination);
    } else {
      print('No GPS installed');
    }
  }
}

// Example 3: Person with Address (Composition vs Inheritance)
class Address {
  final String street;
  final String city;
  final String country;

  Address(this.street, this.city, this.country);

  @override
  String toString() => '$street, $city, $country';
}

class Person {
  final String name;
  final Address address; // Person HAS-A Address

  Person(this.name, this.address);

  void printInfo() {
    print('$name lives at $address');
  }
}

// Example 4: Document with multiple components
class DocumentMetadata {
  final String author;
  final DateTime created;
  DateTime lastModified;

  DocumentMetadata(this.author)
    : created = DateTime.now(),
      lastModified = DateTime.now();

  void update() {
    lastModified = DateTime.now();
  }
}

class DocumentContent {
  String _text = '';

  String get text => _text;

  void write(String content) {
    _text = content;
  }

  void append(String content) {
    _text += content;
  }

  int get wordCount => _text.split(' ').where((w) => w.isNotEmpty).length;
}

class Document {
  final String title;
  final DocumentMetadata metadata;
  final DocumentContent content;

  Document(this.title, String author)
    : metadata = DocumentMetadata(author),
      content = DocumentContent();

  void write(String text) {
    content.write(text);
    metadata.update();
  }

  void printSummary() {
    print('\n--- Document Summary ---');
    print('Title: $title');
    print('Author: ${metadata.author}');
    print('Created: ${metadata.created}');
    print('Words: ${content.wordCount}');
  }
}

// Main demonstration
void main() {
  print('=== Object Composition Examples ===\n');

  // Example 1: Basic Car Composition
  print('--- Example 1: Gas Car ---');
  var gasCar = Car('Toyota', Engine(200), Wheels(4), Radio());

  gasCar.start();
  gasCar.drive();
  gasCar.listenToMusic();
  gasCar.stop();

  // Example 2: Electric Car with different components
  print('\n--- Example 2: Electric Car ---');
  var tesla = ElectricCar('Tesla', Battery(), Wheels(4), gps: GPS());

  tesla.drive();
  tesla.navigateTo('Home');

  // Car without GPS
  var basicEV = ElectricCar('Basic EV', Battery(), Wheels(4));
  basicEV.navigateTo('Home'); // Will show "No GPS installed"

  // Example 3: Person with Address
  print('\n--- Example 3: Person Composition ---');
  var person = Person('Alice', Address('123 Main St', 'New York', 'USA'));
  person.printInfo();

  // Example 4: Document Composition
  print('\n--- Example 4: Document Composition ---');
  var doc = Document('My Essay', 'Bob');
  doc.write('This is a sample document about object composition in Dart.');
  doc.printSummary();

  // Key Benefits
  print('\n--- Why Composition? ---');
  print('✓ More flexible than inheritance');
  print('✓ Easier to change components at runtime');
  print('✓ Avoids deep inheritance hierarchies');
  print('✓ Better code reuse');
  print('✓ Easier to test individual components');
}

