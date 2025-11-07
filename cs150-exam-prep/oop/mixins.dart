/// Mixins in Dart
/// Mixins: A way to reuse code in multiple class hierarchies
/// Syntax: class MyClass extends ParentClass with Mixin1, Mixin2

// Example 1: Basic Mixin
mixin Swimmer {
  void swim() {
    print('Swimming 🏊');
  }
}

mixin Flyer {
  void fly() {
    print('Flying ✈️');
  }
}

mixin Walker {
  void walk() {
    print('Walking 🚶');
  }
}

// Different classes using different mixins
class Duck extends Animal with Swimmer, Flyer, Walker {
  Duck(String name) : super(name);
}

class Fish extends Animal with Swimmer {
  Fish(String name) : super(name);
}

class Bird extends Animal with Flyer, Walker {
  Bird(String name) : super(name);
}

class Human extends Animal with Walker, Swimmer {
  Human(String name) : super(name);
}

class Animal {
  final String name;
  Animal(this.name);

  void introduce() {
    print('I am $name');
  }
}

// Example 2: Mixins with State
mixin Audible {
  int volume = 50;

  void playSound() {
    print('Playing sound at volume $volume');
  }

  void increaseVolume() {
    volume = (volume + 10).clamp(0, 100);
    print('Volume: $volume');
  }

  void decreaseVolume() {
    volume = (volume - 10).clamp(0, 100);
    print('Volume: $volume');
  }
}

mixin Rechargeable {
  int battery = 100;

  void charge() {
    battery = 100;
    print('🔋 Fully charged');
  }

  void useBattery(int amount) {
    battery = (battery - amount).clamp(0, 100);
    print('🔋 Battery: $battery%');
  }
}

class Smartphone with Audible, Rechargeable {
  final String brand;

  Smartphone(this.brand);

  void makeCall() {
    print('📱 Calling...');
    playSound();
    useBattery(5);
  }
}

class Laptop with Audible, Rechargeable {
  final String model;

  Laptop(this.model);

  void work() {
    print('💻 Working on $model');
    useBattery(10);
  }
}

// Example 3: Mixin with 'on' clause (requires specific superclass)
class Vehicle {
  String brand;
  Vehicle(this.brand);
}

mixin Electric on Vehicle {
  int batteryLevel = 100;

  void electricDrive() {
    print('$brand driving electrically - Battery: $batteryLevel%');
    batteryLevel -= 10;
  }
}

mixin GPS on Vehicle {
  void navigate(String destination) {
    print('$brand navigating to $destination');
  }
}

class Tesla extends Vehicle with Electric, GPS {
  Tesla(String model) : super(model);
}

// Example 4: Order matters in mixins
mixin A {
  void message() => print('Message from A');
}

mixin B {
  void message() => print('Message from B');
}

class TestOrder1 with A, B {}

class TestOrder2 with B, A {}

// Example 5: Practical example - Logging and Validation
mixin Loggable {
  void log(String message) {
    print('[LOG ${DateTime.now()}] $message');
  }
}

mixin Validatable {
  bool validate(String input) {
    if (input.isEmpty) {
      print('Validation failed: empty input');
      return false;
    }
    print('Validation passed');
    return true;
  }
}

class UserForm with Loggable, Validatable {
  void submit(String username, String email) {
    log('Attempting to submit form');

    if (validate(username) && validate(email)) {
      log('Form submitted successfully');
      print('User created: $username ($email)');
    } else {
      log('Form submission failed');
    }
  }
}

// Example 6: Abstract mixin with required methods
mixin Drawable {
  // Mixin can have abstract methods
  void draw();

  void display() {
    print('Displaying shape:');
    draw();
  }
}

class Circle with Drawable {
  final double radius;
  Circle(this.radius);

  @override
  void draw() {
    print('Drawing circle with radius $radius');
  }
}

class Square with Drawable {
  final double side;
  Square(this.side);

  @override
  void draw() {
    print('Drawing square with side $side');
  }
}

// Example 7: Mixins for game characters
mixin Attackable {
  int attackPower = 10;

  void attack(String target) {
    print('⚔️  Attacking $target with power $attackPower');
  }
}

mixin Defendable {
  int defense = 5;

  void defend() {
    print('🛡️  Defending with defense $defense');
  }
}

mixin MagicUser {
  int mana = 100;

  void castSpell(String spell) {
    if (mana >= 20) {
      print('✨ Casting $spell');
      mana -= 20;
    } else {
      print('Not enough mana!');
    }
  }
}

class Warrior with Attackable, Defendable {
  final String name;
  Warrior(this.name);
}

class Mage with Attackable, MagicUser {
  final String name;
  Mage(this.name);
}

class Paladin with Attackable, Defendable, MagicUser {
  final String name;
  Paladin(this.name);
}

// Main demonstration
void main() {
  print('=== Mixin Examples ===\n');

  // Example 1: Animals with different abilities
  print('--- Example 1: Animal Abilities ---');
  var duck = Duck('Donald');
  duck.introduce();
  duck.walk();
  duck.swim();
  duck.fly();

  print('');
  var fish = Fish('Nemo');
  fish.introduce();
  fish.swim();
  // fish.walk(); // Error: Fish can't walk

  // Example 2: Devices with mixins
  print('\n--- Example 2: Smart Devices ---');
  var phone = Smartphone('iPhone');
  phone.makeCall();
  phone.increaseVolume();
  phone.useBattery(20);
  phone.charge();

  // Example 3: Electric vehicle
  print('\n--- Example 3: Electric Vehicle ---');
  var tesla = Tesla('Model 3');
  tesla.electricDrive();
  tesla.navigate('Home');

  // Example 4: Order matters
  print('\n--- Example 4: Mixin Order ---');
  var test1 = TestOrder1();
  test1.message(); // B's message (last mixin wins)

  var test2 = TestOrder2();
  test2.message(); // A's message (last mixin wins)

  // Example 5: Form with validation and logging
  print('\n--- Example 5: Form Validation ---');
  var form = UserForm();
  form.submit('john_doe', 'john@example.com');
  form.submit('', 'invalid@test.com');

  // Example 6: Drawable shapes
  print('\n--- Example 6: Drawable Shapes ---');
  var circle = Circle(5.0);
  circle.display();

  var square = Square(4.0);
  square.display();

  // Example 7: Game characters
  print('\n--- Example 7: Game Characters ---');
  var warrior = Warrior('Conan');
  warrior.attack('Dragon');
  warrior.defend();

  print('');
  var mage = Mage('Gandalf');
  mage.castSpell('Fireball');
  mage.attack('Orc');

  print('');
  var paladin = Paladin('Arthur');
  paladin.attack('Evil Knight');
  paladin.defend();
  paladin.castSpell('Heal');

  // Key Points
  print('\n--- Mixin Benefits ---');
  print('✓ Code reuse across different class hierarchies');
  print('✓ Add functionality without inheritance');
  print('✓ Multiple mixins can be applied to one class');
  print('✓ More flexible than single inheritance');
  print('✓ Great for adding common behaviors');
}

