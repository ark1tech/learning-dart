/// MVC Pattern - Model
/// The Model represents the data and business logic

// Simple Counter Model
class CounterModel {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
  }

  void decrement() {
    _count--;
  }

  void reset() {
    _count = 0;
  }
}

// User Model with validation
class User {
  String _name;
  String _email;
  int _age;

  User(this._name, this._email, this._age);

  String get name => _name;
  String get email => _email;
  int get age => _age;

  set name(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
    _name = value;
  }

  set email(String value) {
    if (!value.contains('@')) {
      throw ArgumentError('Invalid email format');
    }
    _email = value;
  }

  set age(int value) {
    if (value < 0 || value > 150) {
      throw ArgumentError('Age must be between 0 and 150');
    }
    _age = value;
  }

  @override
  String toString() => 'User(name: $name, email: $email, age: $age)';
}

// TodoItem Model
class TodoItem {
  final String id;
  String title;
  bool isCompleted;
  DateTime createdAt;

  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  void toggle() {
    isCompleted = !isCompleted;
  }

  @override
  String toString() => '$title ${isCompleted ? "✓" : "○"}';
}

// TodoList Model with business logic
class TodoListModel {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  int get totalCount => _todos.length;
  int get completedCount => _todos.where((todo) => todo.isCompleted).length;
  int get activeCount => totalCount - completedCount;

  void addTodo(String title) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Todo title cannot be empty');
    }

    var todo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );
    _todos.add(todo);
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodo(String id) {
    var todo = _todos.firstWhere((t) => t.id == id);
    todo.toggle();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
  }

  List<TodoItem> getActiveTodos() {
    return _todos.where((todo) => !todo.isCompleted).toList();
  }

  List<TodoItem> getCompletedTodos() {
    return _todos.where((todo) => todo.isCompleted).toList();
  }
}

// Example usage
void main() {
  print('=== MVC Model Examples ===\n');

  // Example 1: Counter Model
  print('--- Counter Model ---');
  var counter = CounterModel();
  print('Initial count: ${counter.count}');
  counter.increment();
  counter.increment();
  print('After 2 increments: ${counter.count}');
  counter.decrement();
  print('After 1 decrement: ${counter.count}\n');

  // Example 2: User Model with validation
  print('--- User Model ---');
  try {
    var user = User('Alice', 'alice@example.com', 25);
    print('Created: $user');

    user.name = 'Alice Smith';
    print('Updated name: $user');

    // This will throw an error
    user.email = 'invalid-email';
  } catch (e) {
    print('Validation error: $e\n');
  }

  // Example 3: TodoList Model
  print('--- TodoList Model ---');
  var todoList = TodoListModel();

  todoList.addTodo('Learn Dart');
  todoList.addTodo('Build an app');
  todoList.addTodo('Study MVC pattern');

  print('Total todos: ${todoList.totalCount}');
  for (var todo in todoList.todos) {
    print('  - $todo');
  }

  todoList.toggleTodo(todoList.todos[0].id);
  print('\nAfter completing first todo:');
  print('Completed: ${todoList.completedCount}');
  print('Active: ${todoList.activeCount}');

  print('\nActive todos:');
  for (var todo in todoList.getActiveTodos()) {
    print('  - $todo');
  }
}
