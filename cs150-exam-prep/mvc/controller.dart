// Simplified Model
class CounterModel {
  int _count = 0;
  int get count => _count;
  void increment() => _count++;
  void decrement() => _count--;
  void reset() => _count = 0;
}

// Simplified View
class CounterView {
  void display(int count) => print('Count: $count');
  void showMessage(String msg) => print(msg);
}

// CONTROLLER: Coordinates Model and View
class CounterController {
  final CounterModel model;
  final CounterView view;

  CounterController(this.model, this.view);

  // Handle user actions
  void handleIncrement() {
    model.increment();
    view.display(model.count);
    view.showMessage('Incremented!');
  }

  void handleDecrement() {
    model.decrement();
    view.display(model.count);
    view.showMessage('Decremented!');
  }

  void handleReset() {
    model.reset();
    view.display(model.count);
    view.showMessage('Reset to 0!');
  }

  void initialize() {
    view.display(model.count);
  }
}

// More complex example: User Controller
class User {
  String name;
  String email;
  int age;
  User(this.name, this.email, this.age);
}

class UserView {
  void displayUser(User user) {
    print('\n--- User Info ---');
    print('Name:  ${user.name}');
    print('Email: ${user.email}');
    print('Age:   ${user.age}');
  }

  void showSuccess(String msg) => print('✓ $msg');
  void showError(String msg) => print('✗ $msg');
}

class UserController {
  final User model;
  final UserView view;

  UserController(this.model, this.view);

  void showUser() {
    view.displayUser(model);
  }

  void updateName(String newName) {
    if (newName.trim().isEmpty) {
      view.showError('Name cannot be empty');
      return;
    }
    model.name = newName;
    view.showSuccess('Name updated to: $newName');
    view.displayUser(model);
  }

  void updateEmail(String newEmail) {
    if (!newEmail.contains('@')) {
      view.showError('Invalid email format');
      return;
    }
    model.email = newEmail;
    view.showSuccess('Email updated');
    view.displayUser(model);
  }

  void updateAge(int newAge) {
    if (newAge < 0 || newAge > 150) {
      view.showError('Age must be between 0 and 150');
      return;
    }
    model.age = newAge;
    view.showSuccess('Age updated');
    view.displayUser(model);
  }
}

// Todo List Controller
class TodoItem {
  final String id;
  String title;
  bool isCompleted;
  TodoItem(this.id, this.title, {this.isCompleted = false});
  void toggle() => isCompleted = !isCompleted;
}

class TodoListModel {
  final List<TodoItem> _todos = [];
  List<TodoItem> get todos => _todos;
  int get completedCount => _todos.where((t) => t.isCompleted).length;
  int get activeCount => _todos.length - completedCount;

  void add(TodoItem todo) => _todos.add(todo);
  void remove(String id) => _todos.removeWhere((t) => t.id == id);
  TodoItem? findById(String id) => _todos.cast<TodoItem?>().firstWhere(
    (t) => t?.id == id,
    orElse: () => null,
  );
}

class TodoListView {
  void displayTodos(List<TodoItem> todos) {
    print('\n📝 Todo List:');
    if (todos.isEmpty) {
      print('  No todos yet!');
      return;
    }
    for (var i = 0; i < todos.length; i++) {
      var status = todos[i].isCompleted ? '✓' : ' ';
      print('  ${i + 1}. [$status] ${todos[i].title}');
    }
  }

  void displayStats(int total, int completed, int active) {
    print('\nStats: Total=$total, Completed=$completed, Active=$active');
  }

  void showMessage(String msg) => print('→ $msg');
}

class TodoListController {
  final TodoListModel model;
  final TodoListView view;

  TodoListController(this.model, this.view);

  void showAllTodos() {
    view.displayTodos(model.todos);
    view.displayStats(
      model.todos.length,
      model.completedCount,
      model.activeCount,
    );
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) {
      view.showMessage('Cannot add empty todo');
      return;
    }

    var todo = TodoItem(
      DateTime.now().millisecondsSinceEpoch.toString(),
      title.trim(),
    );

    model.add(todo);
    view.showMessage('Added: "$title"');
    showAllTodos();
  }

  void toggleTodo(int index) {
    if (index < 0 || index >= model.todos.length) {
      view.showMessage('Invalid todo index');
      return;
    }

    var todo = model.todos[index];
    todo.toggle();

    var status = todo.isCompleted ? 'completed' : 'active';
    view.showMessage('Marked "${todo.title}" as $status');
    showAllTodos();
  }

  void removeTodo(int index) {
    if (index < 0 || index >= model.todos.length) {
      view.showMessage('Invalid todo index');
      return;
    }

    var todo = model.todos[index];
    model.remove(todo.id);
    view.showMessage('Removed: "${todo.title}"');
    showAllTodos();
  }
}

// Main demonstration
void main() {
  print('=== MVC Controller Examples ===');

  // Example 1: Counter Controller
  print('\n--- Example 1: Counter Controller ---');
  var counterModel = CounterModel();
  var counterView = CounterView();
  var counterController = CounterController(counterModel, counterView);

  counterController.initialize();
  counterController.handleIncrement();
  counterController.handleIncrement();
  counterController.handleDecrement();
  counterController.handleReset();

  // Example 2: User Controller
  print('\n--- Example 2: User Controller ---');
  var user = User('John Doe', 'john@example.com', 25);
  var userView = UserView();
  var userController = UserController(user, userView);

  userController.showUser();
  userController.updateName('Jane Smith');
  userController.updateEmail('invalid-email'); // Will show error
  userController.updateEmail('jane@example.com');
  userController.updateAge(30);

  // Example 3: TodoList Controller
  print('\n--- Example 3: TodoList Controller ---');
  var todoModel = TodoListModel();
  var todoView = TodoListView();
  var todoController = TodoListController(todoModel, todoView);

  todoController.showAllTodos();
  todoController.addTodo('Learn Dart');
  todoController.addTodo('Study MVC pattern');
  todoController.addTodo('Build an app');
  todoController.toggleTodo(0); // Complete first todo
  todoController.removeTodo(1); // Remove second todo

  print('\n--- Key Points ---');
  print('1. Controller receives user input');
  print('2. Controller updates the Model');
  print('3. Controller tells View to update display');
  print('4. Model and View never communicate directly');
}
