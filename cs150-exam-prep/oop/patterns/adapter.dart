/// Adapter Design Pattern
/// Converts the interface of a class into another interface clients expect
/// Allows classes to work together that couldn't otherwise due to incompatible interfaces

// Example 1: Basic Adapter Pattern
// Target interface that client expects
abstract class MediaPlayer {
  void play(String filename);
}

// Adaptee - Existing class with different interface
class AdvancedMediaPlayer {
  void playMp4(String filename) {
    print('🎥 Playing MP4 file: $filename');
  }

  void playVlc(String filename) {
    print('🎬 Playing VLC file: $filename');
  }
}

// Adapter - Makes AdvancedMediaPlayer compatible with MediaPlayer
class MediaAdapter implements MediaPlayer {
  final AdvancedMediaPlayer advancedPlayer;

  MediaAdapter(this.advancedPlayer);

  @override
  void play(String filename) {
    if (filename.endsWith('.mp4')) {
      advancedPlayer.playMp4(filename);
    } else if (filename.endsWith('.vlc')) {
      advancedPlayer.playVlc(filename);
    } else {
      print('Unsupported format');
    }
  }
}

// Client code
class AudioPlayer implements MediaPlayer {
  @override
  void play(String filename) {
    if (filename.endsWith('.mp3')) {
      print('🎵 Playing MP3 file: $filename');
    } else {
      // Use adapter for other formats
      var adapter = MediaAdapter(AdvancedMediaPlayer());
      adapter.play(filename);
    }
  }
}

// Example 2: Payment Gateway Adapter
// Third-party payment service (incompatible interface)
class StripePayment {
  void processStripePayment(double amount, String cardToken) {
    print('💳 Stripe: Processing \$$amount with token $cardToken');
  }
}

class PayPalPayment {
  void sendPayPalPayment(String email, double amount) {
    print('💳 PayPal: Sending \$$amount to $email');
  }
}

// Target interface
abstract class PaymentProcessor {
  void processPayment(double amount, String details);
}

// Adapters
class StripeAdapter implements PaymentProcessor {
  final StripePayment stripe;

  StripeAdapter(this.stripe);

  @override
  void processPayment(double amount, String details) {
    // Convert details to card token format
    var cardToken = 'tok_$details';
    stripe.processStripePayment(amount, cardToken);
  }
}

class PayPalAdapter implements PaymentProcessor {
  final PayPalPayment paypal;

  PayPalAdapter(this.paypal);

  @override
  void processPayment(double amount, String details) {
    // details is email for PayPal
    paypal.sendPayPalPayment(details, amount);
  }
}

// Example 3: Data Source Adapter
// Old API
class OldDatabase {
  Map<String, dynamic> getData(int id) {
    return {
      'user_id': id,
      'user_name': 'John Doe',
      'user_email': 'john@example.com',
    };
  }
}

// New interface
abstract class DataSource {
  User fetchUser(int id);
}

class User {
  final int id;
  final String name;
  final String email;

  User(this.id, this.name, this.email);

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

// Adapter to convert old API to new interface
class DatabaseAdapter implements DataSource {
  final OldDatabase oldDb;

  DatabaseAdapter(this.oldDb);

  @override
  User fetchUser(int id) {
    var data = oldDb.getData(id);

    // Convert old format to new User object
    return User(data['user_id'], data['user_name'], data['user_email']);
  }
}

// Example 4: Temperature Adapter (Unit Conversion)
// European system (Celsius)
class CelsiusTemperature {
  final double temperature;

  CelsiusTemperature(this.temperature);

  double getCelsius() => temperature;
}

// American system (Fahrenheit)
abstract class TemperatureReader {
  double getFahrenheit();
}

// Adapter to convert Celsius to Fahrenheit
class TemperatureAdapter implements TemperatureReader {
  final CelsiusTemperature celsius;

  TemperatureAdapter(this.celsius);

  @override
  double getFahrenheit() {
    return (celsius.getCelsius() * 9 / 5) + 32;
  }
}

// Example 5: Socket Adapter (Real-world example)
class EuropeanSocket {
  void plugIn230V() {
    print('🔌 Connected to 230V European socket');
  }
}

class AmericanSocket {
  void plugIn110V() {
    print('🔌 Connected to 110V American socket');
  }
}

abstract class UniversalPlug {
  void connect();
}

class EuropeanToUniversalAdapter implements UniversalPlug {
  final EuropeanSocket socket;

  EuropeanToUniversalAdapter(this.socket);

  @override
  void connect() {
    print('Using European adapter...');
    socket.plugIn230V();
  }
}

class AmericanToUniversalAdapter implements UniversalPlug {
  final AmericanSocket socket;

  AmericanToUniversalAdapter(this.socket);

  @override
  void connect() {
    print('Using American adapter...');
    socket.plugIn110V();
  }
}

class Laptop {
  void charge(UniversalPlug plug) {
    print('\n💻 Laptop charging...');
    plug.connect();
    print('✓ Charging successfully');
  }
}

// Main demonstration
void main() {
  print('=== Adapter Pattern Examples ===\n');

  // Example 1: Media Player
  print('--- Example 1: Media Player Adapter ---');
  var player = AudioPlayer();
  player.play('song.mp3');
  player.play('video.mp4');
  player.play('movie.vlc');

  // Example 2: Payment Gateway
  print('\n--- Example 2: Payment Gateway Adapter ---');
  PaymentProcessor stripePayment = StripeAdapter(StripePayment());
  stripePayment.processPayment(99.99, 'card123');

  PaymentProcessor paypalPayment = PayPalAdapter(PayPalPayment());
  paypalPayment.processPayment(49.99, 'user@example.com');

  // Example 3: Database Adapter
  print('\n--- Example 3: Database Adapter ---');
  DataSource dataSource = DatabaseAdapter(OldDatabase());
  var user = dataSource.fetchUser(1);
  print('Fetched: $user');

  // Example 4: Temperature Adapter
  print('\n--- Example 4: Temperature Adapter ---');
  var temp = CelsiusTemperature(25.0);
  var tempReader = TemperatureAdapter(temp);
  print('${temp.getCelsius()}°C = ${tempReader.getFahrenheit()}°F');

  // Example 5: Socket Adapter
  print('\n--- Example 5: Universal Socket Adapter ---');
  var laptop = Laptop();

  var europeanSocket = EuropeanSocket();
  var euAdapter = EuropeanToUniversalAdapter(europeanSocket);
  laptop.charge(euAdapter);

  var americanSocket = AmericanSocket();
  var usAdapter = AmericanToUniversalAdapter(americanSocket);
  laptop.charge(usAdapter);

  // Key Points
  print('\n--- Adapter Pattern Benefits ---');
  print('✓ Makes incompatible interfaces work together');
  print('✓ Reuse existing code without modification');
  print('✓ Follows Open/Closed Principle');
  print('✓ Single Responsibility - adapts interface');
  print('✓ Useful for integrating third-party libraries');
}
