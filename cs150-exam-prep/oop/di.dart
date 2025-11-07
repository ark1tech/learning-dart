/// Dependency Injection (DI) in Dart
/// DI: Providing dependencies from outside rather than creating them internally
/// Makes code more testable, flexible, and maintainable

// Example 1: Without DI (Tight Coupling) - BAD
class DatabaseService {
  void saveData(String data) {
    print('Saving to database: $data');
  }
}

class UserService_Bad {
  final DatabaseService db = DatabaseService(); // Tightly coupled!

  void createUser(String name) {
    db.saveData('User: $name');
  }
}

// Example 2: With Constructor Injection (Loose Coupling) - GOOD
class IDataService {
  void save(String data) {}
}

class DatabaseServiceImpl implements IDataService {
  @override
  void save(String data) {
    print('💾 Saving to database: $data');
  }
}

class FileService implements IDataService {
  @override
  void save(String data) {
    print('📁 Saving to file: $data');
  }
}

class CloudService implements IDataService {
  @override
  void save(String data) {
    print('☁️  Saving to cloud: $data');
  }
}

class UserService {
  final IDataService dataService; // Dependency injected

  UserService(this.dataService); // Constructor injection

  void createUser(String name) {
    print('Creating user: $name');
    dataService.save('User: $name');
  }
}

// Example 3: Logger with DI
abstract class Logger {
  void log(String message);
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) {
    print('[CONSOLE] $message');
  }
}

class FileLogger implements Logger {
  final String filename;

  FileLogger(this.filename);

  @override
  void log(String message) {
    print('[FILE: $filename] $message');
  }
}

class EmailService {
  final Logger logger;

  EmailService(this.logger); // Inject logger

  void sendEmail(String to, String subject) {
    logger.log('Attempting to send email to $to');
    // Email sending logic here
    print('📧 Sending email to $to: $subject');
    logger.log('Email sent successfully');
  }
}

// Example 4: Multiple Dependencies
class PaymentGateway {
  void processPayment(double amount) {
    print('💳 Processing payment: \$$amount');
  }
}

class NotificationService {
  void notify(String message) {
    print('🔔 Notification: $message');
  }
}

class OrderService {
  final IDataService database;
  final PaymentGateway payment;
  final NotificationService notification;
  final Logger logger;

  // Multiple dependencies injected
  OrderService(this.database, this.payment, this.notification, this.logger);

  void placeOrder(String item, double amount) {
    logger.log('Placing order for $item');

    database.save('Order: $item');
    payment.processPayment(amount);
    notification.notify('Order placed for $item');

    logger.log('Order completed');
  }
}

// Example 5: Factory Pattern with DI
class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  void request(String endpoint) {
    print('🌐 API Request: $baseUrl$endpoint');
  }
}

class UserRepository {
  final ApiClient api;

  UserRepository(this.api);

  void getUsers() {
    api.request('/users');
  }

  void getUser(int id) {
    api.request('/users/$id');
  }
}

// Simple DI Container
class ServiceContainer {
  final Map<Type, Object> _services = {};

  void register<T extends Object>(T service) {
    _services[T] = service as Object;
  }

  T get<T>() {
    var service = _services[T];
    if (service == null) {
      throw Exception('Service $T not found');
    }
    return service as T;
  }
}

// Example 6: Setter Injection (alternative to constructor injection)
class ReportGenerator {
  Logger? _logger;

  // Setter injection
  set logger(Logger logger) {
    _logger = logger;
  }

  void generateReport(String title) {
    _logger?.log('Generating report: $title');
    print('📊 Report: $title');
    _logger?.log('Report generated');
  }
}

// Main demonstration
void main() {
  print('=== Dependency Injection Examples ===\n');

  // Example 1: Bad vs Good
  print('--- Without DI (Tight Coupling) ---');
  var userServiceBad = UserService_Bad();
  userServiceBad.createUser('Alice');

  print('\n--- With DI (Loose Coupling) ---');
  // We can easily swap implementations!
  var userService1 = UserService(DatabaseServiceImpl());
  userService1.createUser('Bob');

  var userService2 = UserService(FileService());
  userService2.createUser('Charlie');

  var userService3 = UserService(CloudService());
  userService3.createUser('Diana');

  // Example 2: Logger DI
  print('\n--- Logger Injection ---');
  var emailService1 = EmailService(ConsoleLogger());
  emailService1.sendEmail('bob@example.com', 'Welcome!');

  print('');
  var emailService2 = EmailService(FileLogger('app.log'));
  emailService2.sendEmail('alice@example.com', 'Update');

  // Example 3: Multiple Dependencies
  print('\n--- Multiple Dependencies ---');
  var orderService = OrderService(
    DatabaseServiceImpl(),
    PaymentGateway(),
    NotificationService(),
    ConsoleLogger(),
  );
  orderService.placeOrder('Laptop', 999.99);

  // Example 4: API with DI
  print('\n--- API Client Injection ---');
  var devApi = ApiClient('https://dev.example.com');
  var prodApi = ApiClient('https://api.example.com');

  var devRepo = UserRepository(devApi);
  devRepo.getUsers();

  var prodRepo = UserRepository(prodApi);
  prodRepo.getUser(123);

  // Example 5: DI Container
  print('\n--- DI Container ---');
  var container = ServiceContainer();
  container.register<Logger>(ConsoleLogger());
  container.register<IDataService>(DatabaseServiceImpl());

  var logger = container.get<Logger>();
  logger.log('Using DI Container!');

  var dataService = container.get<IDataService>();
  dataService.save('Data from container');

  // Example 6: Setter Injection
  print('\n--- Setter Injection ---');
  var reportGen = ReportGenerator();
  reportGen.logger = ConsoleLogger();
  reportGen.generateReport('Monthly Sales');

  // Benefits
  print('\n--- Benefits of DI ---');
  print('✓ Loose coupling - easy to change implementations');
  print('✓ Testability - inject mock dependencies for testing');
  print('✓ Flexibility - swap dependencies at runtime');
  print('✓ Single Responsibility - classes focus on their job');
  print('✓ Easier maintenance and debugging');
}
