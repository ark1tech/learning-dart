/// Observer Design Pattern
/// Defines a one-to-many dependency between objects
/// When one object changes state, all dependents are notified automatically

// Example 1: Basic Observer Pattern
// Observer interface
abstract class Observer {
  void update(String message);
}

// Subject (Observable)
class Subject {
  final List<Observer> _observers = [];

  void attach(Observer observer) {
    _observers.add(observer);
    print('Observer attached. Total: ${_observers.length}');
  }

  void detach(Observer observer) {
    _observers.remove(observer);
    print('Observer detached. Total: ${_observers.length}');
  }

  void notify(String message) {
    print('\n📢 Notifying all observers...');
    for (var observer in _observers) {
      observer.update(message);
    }
  }
}

// Concrete Observers
class EmailObserver implements Observer {
  final String email;

  EmailObserver(this.email);

  @override
  void update(String message) {
    print('📧 Email to $email: $message');
  }
}

class SMSObserver implements Observer {
  final String phoneNumber;

  SMSObserver(this.phoneNumber);

  @override
  void update(String message) {
    print('📱 SMS to $phoneNumber: $message');
  }
}

class PushNotificationObserver implements Observer {
  final String deviceId;

  PushNotificationObserver(this.deviceId);

  @override
  void update(String message) {
    print('🔔 Push to $deviceId: $message');
  }
}

// Example 2: Stock Market Observer
class Stock {
  final String symbol;
  double _price;
  final List<StockObserver> _observers = [];

  Stock(this.symbol, this._price);

  double get price => _price;

  void subscribe(StockObserver observer) {
    _observers.add(observer);
  }

  void unsubscribe(StockObserver observer) {
    _observers.remove(observer);
  }

  void setPrice(double newPrice) {
    var oldPrice = _price;
    _price = newPrice;

    print('\n📊 $symbol: \$$oldPrice → \$$newPrice');
    _notifyObservers(oldPrice, newPrice);
  }

  void _notifyObservers(double oldPrice, double newPrice) {
    for (var observer in _observers) {
      observer.onPriceChange(symbol, oldPrice, newPrice);
    }
  }
}

abstract class StockObserver {
  void onPriceChange(String symbol, double oldPrice, double newPrice);
}

class Investor implements StockObserver {
  final String name;

  Investor(this.name);

  @override
  void onPriceChange(String symbol, double oldPrice, double newPrice) {
    var change = newPrice - oldPrice;
    var emoji = change > 0 ? '📈' : '📉';
    print(
      '$emoji $name notified: $symbol changed by \$${change.toStringAsFixed(2)}',
    );
  }
}

// Example 3: Weather Station
class WeatherData {
  double _temperature = 0;
  double _humidity = 0;
  double _pressure = 0;
  final List<WeatherObserver> _observers = [];

  void registerObserver(WeatherObserver observer) {
    _observers.add(observer);
  }

  void removeObserver(WeatherObserver observer) {
    _observers.remove(observer);
  }

  void setMeasurements(double temperature, double humidity, double pressure) {
    _temperature = temperature;
    _humidity = humidity;
    _pressure = pressure;
    _notifyObservers();
  }

  void _notifyObservers() {
    for (var observer in _observers) {
      observer.updateWeather(_temperature, _humidity, _pressure);
    }
  }
}

abstract class WeatherObserver {
  void updateWeather(double temperature, double humidity, double pressure);
}

class CurrentConditionsDisplay implements WeatherObserver {
  @override
  void updateWeather(double temperature, double humidity, double pressure) {
    print('🌡️  Current: ${temperature}°C, ${humidity}% humidity');
  }
}

class StatisticsDisplay implements WeatherObserver {
  final List<double> _temperatures = [];

  @override
  void updateWeather(double temperature, double humidity, double pressure) {
    _temperatures.add(temperature);
    var avg = _temperatures.reduce((a, b) => a + b) / _temperatures.length;
    print('📊 Average Temperature: ${avg.toStringAsFixed(1)}°C');
  }
}

class ForecastDisplay implements WeatherObserver {
  @override
  void updateWeather(double temperature, double humidity, double pressure) {
    if (pressure > 1020) {
      print('🌤️  Forecast: Improving weather!');
    } else if (pressure < 1000) {
      print('🌧️  Forecast: Watch out for rain!');
    } else {
      print('☁️  Forecast: More of the same');
    }
  }
}

// Example 4: YouTube Channel (Subscription System)
class YouTubeChannel {
  final String name;
  final List<Subscriber> _subscribers = [];

  YouTubeChannel(this.name);

  void subscribe(Subscriber subscriber) {
    _subscribers.add(subscriber);
    print('${subscriber.name} subscribed to $name');
  }

  void unsubscribe(Subscriber subscriber) {
    _subscribers.remove(subscriber);
    print('${subscriber.name} unsubscribed from $name');
  }

  void uploadVideo(String title) {
    print('\n🎥 $name uploaded: "$title"');
    _notifySubscribers(title);
  }

  void _notifySubscribers(String videoTitle) {
    for (var subscriber in _subscribers) {
      subscriber.notify(name, videoTitle);
    }
  }
}

class Subscriber {
  final String name;

  Subscriber(this.name);

  void notify(String channelName, String videoTitle) {
    print('🔔 $name: New video from $channelName - "$videoTitle"');
  }
}

// Example 5: Event System
class Event {
  final String name;
  final Map<String, dynamic> data;

  Event(this.name, this.data);
}

class EventBus {
  final Map<String, List<Function(Event)>> _listeners = {};

  void on(String eventName, Function(Event) listener) {
    _listeners.putIfAbsent(eventName, () => []);
    _listeners[eventName]!.add(listener);
  }

  void off(String eventName, Function(Event) listener) {
    _listeners[eventName]?.remove(listener);
  }

  void emit(String eventName, Map<String, dynamic> data) {
    var event = Event(eventName, data);
    print('\n⚡ Event emitted: $eventName');

    var listeners = _listeners[eventName];
    if (listeners != null) {
      for (var listener in listeners) {
        listener(event);
      }
    }
  }
}

// Main demonstration
void main() {
  print('=== Observer Pattern Examples ===\n');

  // Example 1: Basic Notification System
  print('--- Example 1: Notification System ---');
  var newsChannel = Subject();

  var emailObserver = EmailObserver('user@example.com');
  var smsObserver = SMSObserver('+1234567890');
  var pushObserver = PushNotificationObserver('device123');

  newsChannel.attach(emailObserver);
  newsChannel.attach(smsObserver);
  newsChannel.attach(pushObserver);

  newsChannel.notify('Breaking news: Dart 3.0 released!');

  newsChannel.detach(smsObserver);
  newsChannel.notify('Update: New features announced');

  // Example 2: Stock Market
  print('\n--- Example 2: Stock Market ---');
  var appleStock = Stock('AAPL', 150.00);

  var investor1 = Investor('Alice');
  var investor2 = Investor('Bob');

  appleStock.subscribe(investor1);
  appleStock.subscribe(investor2);

  appleStock.setPrice(155.50);
  appleStock.setPrice(152.00);

  // Example 3: Weather Station
  print('\n--- Example 3: Weather Station ---');
  var weatherData = WeatherData();

  weatherData.registerObserver(CurrentConditionsDisplay());
  weatherData.registerObserver(StatisticsDisplay());
  weatherData.registerObserver(ForecastDisplay());

  print('\n🌡️  Weather update 1:');
  weatherData.setMeasurements(25.5, 65, 1013);

  print('\n🌡️  Weather update 2:');
  weatherData.setMeasurements(27.0, 70, 1025);

  // Example 4: YouTube Subscriptions
  print('\n--- Example 4: YouTube Channel ---');
  var channel = YouTubeChannel('TechTutorials');

  var sub1 = Subscriber('John');
  var sub2 = Subscriber('Emma');

  channel.subscribe(sub1);
  channel.subscribe(sub2);

  channel.uploadVideo('Learn Dart in 10 Minutes');

  channel.unsubscribe(sub1);
  channel.uploadVideo('Advanced Dart Patterns');

  // Example 5: Event Bus
  print('\n--- Example 5: Event Bus ---');
  var eventBus = EventBus();

  eventBus.on('userLogin', (event) {
    print('✓ Analytics: User logged in - ${event.data['username']}');
  });

  eventBus.on('userLogin', (event) {
    print('✓ Logger: Login event recorded');
  });

  eventBus.on('purchase', (event) {
    print('✓ Email: Order confirmation sent for ${event.data['item']}');
  });

  eventBus.emit('userLogin', {'username': 'alice', 'time': DateTime.now()});
  eventBus.emit('purchase', {'item': 'Laptop', 'amount': 999.99});

  // Key Points
  print('\n--- Observer Pattern Benefits ---');
  print('✓ Loose coupling between subject and observers');
  print('✓ Dynamic subscription/unsubscription');
  print('✓ Broadcast communication to multiple objects');
  print('✓ Open/Closed Principle - add observers without modifying subject');
  print('✓ Perfect for event-driven systems');
}

