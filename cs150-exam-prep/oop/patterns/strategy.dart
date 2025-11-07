/// Strategy Design Pattern
/// Defines a family of algorithms, encapsulates each one, and makes them interchangeable
/// Strategy lets the algorithm vary independently from clients that use it

// Example 1: Payment Strategy
abstract class PaymentStrategy {
  void pay(double amount);
}

class CreditCardPayment implements PaymentStrategy {
  final String cardNumber;
  final String cvv;

  CreditCardPayment(this.cardNumber, this.cvv);

  @override
  void pay(double amount) {
    print(
      '💳 Paying \$$amount with Credit Card ****${cardNumber.substring(cardNumber.length - 4)}',
    );
  }
}

class PayPalPayment implements PaymentStrategy {
  final String email;

  PayPalPayment(this.email);

  @override
  void pay(double amount) {
    print('💰 Paying \$$amount via PayPal ($email)');
  }
}

class CryptoPayment implements PaymentStrategy {
  final String walletAddress;

  CryptoPayment(this.walletAddress);

  @override
  void pay(double amount) {
    print(
      '₿ Paying \$$amount with Crypto (${walletAddress.substring(0, 10)}...)',
    );
  }
}

class ShoppingCart {
  final List<String> items = [];
  PaymentStrategy? _paymentStrategy;

  void addItem(String item) {
    items.add(item);
    print('Added: $item');
  }

  void setPaymentStrategy(PaymentStrategy strategy) {
    _paymentStrategy = strategy;
  }

  void checkout(double amount) {
    if (_paymentStrategy == null) {
      print('Please select a payment method');
      return;
    }

    print('\n🛒 Checking out ${items.length} items...');
    _paymentStrategy!.pay(amount);
    print('✅ Payment successful!\n');
  }
}

// Example 2: Sorting Strategy
abstract class SortStrategy {
  List<int> sort(List<int> data);
  String getName();
}

class BubbleSort implements SortStrategy {
  @override
  String getName() => 'Bubble Sort';

  @override
  List<int> sort(List<int> data) {
    print('Using Bubble Sort...');
    var list = List<int>.from(data);
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length - 1 - i; j++) {
        if (list[j] > list[j + 1]) {
          var temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }
    return list;
  }
}

class QuickSort implements SortStrategy {
  @override
  String getName() => 'Quick Sort';

  @override
  List<int> sort(List<int> data) {
    print('Using Quick Sort...');
    var list = List<int>.from(data);
    list.sort();
    return list;
  }
}

class Sorter {
  SortStrategy _strategy;

  Sorter(this._strategy);

  void setStrategy(SortStrategy strategy) {
    _strategy = strategy;
  }

  List<int> performSort(List<int> data) {
    print('Sorting with ${_strategy.getName()}');
    return _strategy.sort(data);
  }
}

// Example 3: Compression Strategy
abstract class CompressionStrategy {
  void compress(String filename);
}

class ZipCompression implements CompressionStrategy {
  @override
  void compress(String filename) {
    print('📦 Compressing $filename using ZIP format');
    print('   Result: ${filename}.zip');
  }
}

class RarCompression implements CompressionStrategy {
  @override
  void compress(String filename) {
    print('📦 Compressing $filename using RAR format');
    print('   Result: ${filename}.rar');
  }
}

class TarCompression implements CompressionStrategy {
  @override
  void compress(String filename) {
    print('📦 Compressing $filename using TAR format');
    print('   Result: ${filename}.tar.gz');
  }
}

class FileCompressor {
  CompressionStrategy _strategy;

  FileCompressor(this._strategy);

  void setCompressionStrategy(CompressionStrategy strategy) {
    _strategy = strategy;
  }

  void compressFile(String filename) {
    _strategy.compress(filename);
  }
}

// Example 4: Navigation Strategy
abstract class NavigationStrategy {
  void navigate(String from, String to);
}

class WalkingNavigation implements NavigationStrategy {
  @override
  void navigate(String from, String to) {
    print('🚶 Walking route from $from to $to');
    print('   Estimated time: 25 minutes');
  }
}

class DrivingNavigation implements NavigationStrategy {
  @override
  void navigate(String from, String to) {
    print('🚗 Driving route from $from to $to');
    print('   Estimated time: 8 minutes');
  }
}

class PublicTransitNavigation implements NavigationStrategy {
  @override
  void navigate(String from, String to) {
    print('🚌 Public transit route from $from to $to');
    print('   Estimated time: 15 minutes (including wait time)');
  }
}

class Navigator {
  NavigationStrategy _strategy;

  Navigator(this._strategy);

  void setStrategy(NavigationStrategy strategy) {
    _strategy = strategy;
  }

  void buildRoute(String from, String to) {
    _strategy.navigate(from, to);
  }
}

// Example 5: Discount Strategy
abstract class DiscountStrategy {
  double applyDiscount(double price);
  String getDescription();
}

class NoDiscount implements DiscountStrategy {
  @override
  double applyDiscount(double price) => price;

  @override
  String getDescription() => 'No discount';
}

class PercentageDiscount implements DiscountStrategy {
  final double percentage;

  PercentageDiscount(this.percentage);

  @override
  double applyDiscount(double price) {
    return price * (1 - percentage / 100);
  }

  @override
  String getDescription() => '$percentage% off';
}

class FixedAmountDiscount implements DiscountStrategy {
  final double amount;

  FixedAmountDiscount(this.amount);

  @override
  double applyDiscount(double price) {
    return (price - amount).clamp(0, double.infinity);
  }

  @override
  String getDescription() => '\$$amount off';
}

class Product {
  final String name;
  final double price;
  DiscountStrategy _discountStrategy;

  Product(this.name, this.price, [DiscountStrategy? strategy])
    : _discountStrategy = strategy ?? NoDiscount();

  void setDiscountStrategy(DiscountStrategy strategy) {
    _discountStrategy = strategy;
  }

  double getFinalPrice() {
    return _discountStrategy.applyDiscount(price);
  }

  void displayPrice() {
    var finalPrice = getFinalPrice();
    var discount = _discountStrategy.getDescription();

    print('$name:');
    print('  Original: \$${price.toStringAsFixed(2)}');
    print('  Discount: $discount');
    print('  Final: \$${finalPrice.toStringAsFixed(2)}');
  }
}

// Main demonstration
void main() {
  print('=== Strategy Pattern Examples ===\n');

  // Example 1: Payment Strategy
  print('--- Example 1: Payment Methods ---');
  var cart = ShoppingCart();
  cart.addItem('Laptop');
  cart.addItem('Mouse');

  cart.setPaymentStrategy(CreditCardPayment('1234567812345678', '123'));
  cart.checkout(1200.00);

  var cart2 = ShoppingCart();
  cart2.addItem('Book');
  cart2.setPaymentStrategy(PayPalPayment('user@example.com'));
  cart2.checkout(29.99);

  var cart3 = ShoppingCart();
  cart3.addItem('Phone');
  cart3.setPaymentStrategy(CryptoPayment('1A2B3C4D5E6F7G8H9I'));
  cart3.checkout(799.00);

  // Example 2: Sorting Strategy
  print('--- Example 2: Sorting Algorithms ---');
  var numbers = [64, 34, 25, 12, 22, 11, 90];
  print('Original: $numbers\n');

  var sorter = Sorter(BubbleSort());
  var sorted1 = sorter.performSort(numbers);
  print('Result: $sorted1\n');

  sorter.setStrategy(QuickSort());
  var sorted2 = sorter.performSort(numbers);
  print('Result: $sorted2\n');

  // Example 3: Compression Strategy
  print('--- Example 3: File Compression ---');
  var compressor = FileCompressor(ZipCompression());
  compressor.compressFile('document.pdf');

  print('');
  compressor.setCompressionStrategy(RarCompression());
  compressor.compressFile('archive.dat');

  print('');
  compressor.setCompressionStrategy(TarCompression());
  compressor.compressFile('backup.tar');

  // Example 4: Navigation Strategy
  print('\n--- Example 4: Navigation ---');
  var navigator = Navigator(DrivingNavigation());
  navigator.buildRoute('Home', 'Office');

  print('');
  navigator.setStrategy(WalkingNavigation());
  navigator.buildRoute('Home', 'Office');

  print('');
  navigator.setStrategy(PublicTransitNavigation());
  navigator.buildRoute('Home', 'Office');

  // Example 5: Discount Strategy
  print('\n--- Example 5: Discount Strategies ---');
  var laptop = Product('Gaming Laptop', 1500.00);
  laptop.displayPrice();

  print('');
  laptop.setDiscountStrategy(PercentageDiscount(20));
  laptop.displayPrice();

  print('');
  laptop.setDiscountStrategy(FixedAmountDiscount(300));
  laptop.displayPrice();

  // Key Points
  print('\n--- Strategy Pattern Benefits ---');
  print('✓ Defines a family of interchangeable algorithms');
  print('✓ Encapsulates each algorithm in separate class');
  print('✓ Easy to switch strategies at runtime');
  print('✓ Eliminates conditional statements');
  print(
    '✓ Open/Closed Principle - add new strategies without modifying context',
  );
  print('✓ Each strategy can be tested independently');
}

