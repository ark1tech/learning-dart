/// Template Method Design Pattern
/// Defines the skeleton of an algorithm in a base class
/// Lets subclasses override specific steps without changing the algorithm's structure

// Example 1: Beverage Preparation
abstract class Beverage {
  // Template method - defines the algorithm structure
  void prepareRecipe() {
    boilWater();
    brew();
    pourInCup();
    addCondiments();
    print('☕ Your ${getName()} is ready!\n');
  }

  // Common steps
  void boilWater() {
    print('💧 Boiling water...');
  }

  void pourInCup() {
    print('☕ Pouring into cup...');
  }

  // Abstract methods - subclasses must implement
  void brew();
  void addCondiments();
  String getName();
}

class Tea extends Beverage {
  @override
  void brew() {
    print('🍵 Steeping the tea bag...');
  }

  @override
  void addCondiments() {
    print('🍋 Adding lemon...');
  }

  @override
  String getName() => 'Tea';
}

class Coffee extends Beverage {
  @override
  void brew() {
    print('☕ Dripping coffee through filter...');
  }

  @override
  void addCondiments() {
    print('🥛 Adding sugar and milk...');
  }

  @override
  String getName() => 'Coffee';
}

class HotChocolate extends Beverage {
  @override
  void brew() {
    print('🍫 Mixing chocolate powder...');
  }

  @override
  void addCondiments() {
    print('🍦 Adding marshmallows...');
  }

  @override
  String getName() => 'Hot Chocolate';
}

// Example 2: Data Parser
abstract class DataParser {
  // Template method
  void parseDataAndGenerateReport(String filePath) {
    print('📄 Processing $filePath...\n');

    var data = readData(filePath);
    var parsed = parseData(data);
    var analyzed = analyzeData(parsed);
    generateReport(analyzed);

    print('✅ Report generated!\n');
  }

  // Common implementation
  String readData(String filePath) {
    print('📂 Reading data from $filePath...');
    return 'raw_data';
  }

  // Abstract methods - must be implemented by subclasses
  dynamic parseData(String data);
  dynamic analyzeData(dynamic data);
  void generateReport(dynamic result);
}

class CSVParser extends DataParser {
  @override
  dynamic parseData(String data) {
    print('📊 Parsing CSV format...');
    return ['row1', 'row2', 'row3'];
  }

  @override
  dynamic analyzeData(dynamic data) {
    print('🔍 Analyzing CSV data...');
    return {'rows': 3, 'columns': 5};
  }

  @override
  void generateReport(dynamic result) {
    print('📋 CSV Report: $result');
  }
}

class JSONParser extends DataParser {
  @override
  dynamic parseData(String data) {
    print('📊 Parsing JSON format...');
    return {'key': 'value'};
  }

  @override
  dynamic analyzeData(dynamic data) {
    print('🔍 Analyzing JSON data...');
    return {'objects': 10, 'fields': 25};
  }

  @override
  void generateReport(dynamic result) {
    print('📋 JSON Report: $result');
  }
}

class XMLParser extends DataParser {
  @override
  dynamic parseData(String data) {
    print('📊 Parsing XML format...');
    return '<root><data></data></root>';
  }

  @override
  dynamic analyzeData(dynamic data) {
    print('🔍 Analyzing XML data...');
    return {'nodes': 15, 'attributes': 8};
  }

  @override
  void generateReport(dynamic result) {
    print('📋 XML Report: $result');
  }
}

// Example 3: Game AI
abstract class GameAI {
  // Template method
  void takeTurn() {
    collectResources();
    buildStructures();
    buildUnits();
    attack();
    print('');
  }

  void collectResources() {
    print('💰 Collecting resources...');
  }

  // Abstract methods with different implementations
  void buildStructures();
  void buildUnits();
  void attack();
}

class AggressiveAI extends GameAI {
  @override
  void buildStructures() {
    print('🏰 Building barracks quickly...');
  }

  @override
  void buildUnits() {
    print('⚔️  Training many offensive units...');
  }

  @override
  void attack() {
    print('💥 AGGRESSIVE ATTACK!');
  }
}

class DefensiveAI extends GameAI {
  @override
  void buildStructures() {
    print('🏰 Building walls and towers...');
  }

  @override
  void buildUnits() {
    print('🛡️  Training defensive units...');
  }

  @override
  void attack() {
    print('🎯 Cautious counterattack...');
  }
}

class BalancedAI extends GameAI {
  @override
  void buildStructures() {
    print('🏰 Building balanced mix of structures...');
  }

  @override
  void buildUnits() {
    print('⚖️  Training balanced army...');
  }

  @override
  void attack() {
    print('🎯 Tactical strategic attack...');
  }
}

// Example 4: Order Processing with hooks
abstract class OrderProcessor {
  // Template method
  void processOrder(String orderId) {
    print('📦 Processing Order #$orderId\n');

    validateOrder(orderId);

    if (isGift()) {
      wrapAsGift();
    }

    calculateCost();
    processPayment();

    if (isPremiumCustomer()) {
      addBonusItems();
    }

    ship();

    print('✅ Order #$orderId completed!\n');
  }

  // Required steps
  void validateOrder(String orderId) {
    print('✓ Validating order...');
  }

  void calculateCost() {
    print('💰 Calculating total cost...');
  }

  void ship() {
    print('🚚 Shipping order...');
  }

  // Abstract methods
  void processPayment();

  // Hooks - optional methods with default implementation
  bool isGift() => false;
  bool isPremiumCustomer() => false;

  void wrapAsGift() {
    print('🎁 Wrapping as gift...');
  }

  void addBonusItems() {
    print('🎉 Adding bonus items for premium customer...');
  }
}

class StandardOrder extends OrderProcessor {
  @override
  void processPayment() {
    print('💳 Processing standard payment...');
  }
}

class GiftOrder extends OrderProcessor {
  @override
  void processPayment() {
    print('💳 Processing gift payment...');
  }

  @override
  bool isGift() => true;
}

class PremiumOrder extends OrderProcessor {
  @override
  void processPayment() {
    print('💎 Processing premium payment...');
  }

  @override
  bool isPremiumCustomer() => true;
}

// Example 5: House Construction
abstract class HouseBuilder {
  // Template method
  void buildHouse() {
    print('🏗️  Starting construction...\n');

    layFoundation();
    buildWalls();
    buildRoof();
    installWindows();
    installDoors();
    paint();

    print('\n🏡 House construction complete!\n');
  }

  void layFoundation() {
    print('1️⃣  Laying foundation...');
  }

  void installWindows() {
    print('4️⃣  Installing windows...');
  }

  void installDoors() {
    print('5️⃣  Installing doors...');
  }

  // Abstract methods - different for each house type
  void buildWalls();
  void buildRoof();
  void paint();
}

class WoodenHouse extends HouseBuilder {
  @override
  void buildWalls() {
    print('2️⃣  Building wooden walls...');
  }

  @override
  void buildRoof() {
    print('3️⃣  Building wooden shingle roof...');
  }

  @override
  void paint() {
    print('6️⃣  Painting with natural wood stain...');
  }
}

class BrickHouse extends HouseBuilder {
  @override
  void buildWalls() {
    print('2️⃣  Building brick walls...');
  }

  @override
  void buildRoof() {
    print('3️⃣  Building tile roof...');
  }

  @override
  void paint() {
    print('6️⃣  Painting with exterior paint...');
  }
}

// Main demonstration
void main() {
  print('=== Template Method Pattern Examples ===\n');

  // Example 1: Beverage Preparation
  print('--- Example 1: Beverage Preparation ---\n');
  var tea = Tea();
  tea.prepareRecipe();

  var coffee = Coffee();
  coffee.prepareRecipe();

  var hotChoc = HotChocolate();
  hotChoc.prepareRecipe();

  // Example 2: Data Parsers
  print('--- Example 2: Data Parsers ---\n');
  var csvParser = CSVParser();
  csvParser.parseDataAndGenerateReport('data.csv');

  var jsonParser = JSONParser();
  jsonParser.parseDataAndGenerateReport('data.json');

  var xmlParser = XMLParser();
  xmlParser.parseDataAndGenerateReport('data.xml');

  // Example 3: Game AI
  print('--- Example 3: Game AI ---\n');
  print('Aggressive AI Turn:');
  var aggressive = AggressiveAI();
  aggressive.takeTurn();

  print('Defensive AI Turn:');
  var defensive = DefensiveAI();
  defensive.takeTurn();

  print('Balanced AI Turn:');
  var balanced = BalancedAI();
  balanced.takeTurn();

  // Example 4: Order Processing
  print('--- Example 4: Order Processing ---\n');
  var standardOrder = StandardOrder();
  standardOrder.processOrder('ORD001');

  var giftOrder = GiftOrder();
  giftOrder.processOrder('ORD002');

  var premiumOrder = PremiumOrder();
  premiumOrder.processOrder('ORD003');

  // Example 5: House Construction
  print('--- Example 5: House Construction ---\n');
  var woodenHouse = WoodenHouse();
  woodenHouse.buildHouse();

  var brickHouse = BrickHouse();
  brickHouse.buildHouse();

  // Key Points
  print('--- Template Method Benefits ---');
  print('✓ Defines algorithm structure in base class');
  print('✓ Subclasses implement specific steps');
  print('✓ Promotes code reuse');
  print('✓ Controls algorithm flow from parent class');
  print('✓ Follows Hollywood Principle: "Don\'t call us, we\'ll call you"');
  print('✓ Easy to maintain common code in one place');
}
