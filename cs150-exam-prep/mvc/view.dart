/// MVC Pattern - View
/// The View handles the presentation and user interface

// Simple Console View for Counter
class CounterView {
  void displayCount(int count) {
    print('Current Count: $count');
  }

  void displayIncrementMessage() {
    print('Counter incremented!');
  }

  void displayDecrementMessage() {
    print('Counter decremented!');
  }

  void displayResetMessage() {
    print('Counter reset!');
  }

  void showMenu() {
    print('\n--- Counter Menu ---');
    print('1. Increment');
    print('2. Decrement');
    print('3. Reset');
    print('4. Exit');
    print('Enter choice: ');
  }
}

// User View with formatted output
class UserView {
  void displayUser(String name, String email, int age) {
    print('\n╔════════════════════════════════╗');
    print('║        User Profile          ║');
    print('╠════════════════════════════════╣');
    print('║ Name:  $name');
    print('║ Email: $email');
    print('║ Age:   $age');
    print('╚════════════════════════════════╝');
  }

  void displayUpdateSuccess(String field) {
    print('✓ $field updated successfully!');
  }

  void displayError(String message) {
    print('✗ Error: $message');
  }

  void showEditMenu() {
    print('\n--- Edit User ---');
    print('1. Edit Name');
    print('2. Edit Email');
    print('3. Edit Age');
    print('4. Back');
    print('Enter choice: ');
  }
}

// TodoList View
class TodoListView {
  void displayTodos(List<TodoItemDisplay> todos) {
    if (todos.isEmpty) {
      print('\n📝 No todos yet. Add one to get started!');
      return;
    }

    print('\n📝 Todo List:');
    print('─' * 50);
    for (var i = 0; i < todos.length; i++) {
      var todo = todos[i];
      var status = todo.isCompleted ? '✓' : ' ';
      var style = todo.isCompleted ? '\x1B[9m' : ''; // Strikethrough
      var reset = todo.isCompleted ? '\x1B[0m' : '';
      print('${i + 1}. [$status] $style${todo.title}$reset');
    }
    print('─' * 50);
  }

  void displayStats(int total, int completed, int active) {
    print('\nStats: Total: $total | Completed: $completed | Active: $active');
  }

  void displayAddSuccess(String title) {
    print('✓ Added: "$title"');
  }

  void displayRemoveSuccess() {
    print('✓ Todo removed');
  }

  void displayToggleSuccess(String title, bool isCompleted) {
    var status = isCompleted ? 'completed' : 'uncompleted';
    print('✓ "$title" marked as $status');
  }

  void displayError(String message) {
    print('✗ Error: $message');
  }

  void showMenu() {
    print('\n--- Todo Menu ---');
    print('1. Add Todo');
    print('2. Toggle Todo');
    print('3. Remove Todo');
    print('4. Show Active');
    print('5. Show Completed');
    print('6. Clear Completed');
    print('7. Exit');
    print('Enter choice: ');
  }
}

// Data transfer object for displaying todo items
class TodoItemDisplay {
  final String id;
  final String title;
  final bool isCompleted;

  TodoItemDisplay(this.id, this.title, this.isCompleted);
}

// Simple Dashboard View
class DashboardView {
  void displayWelcome(String username) {
    print('\n╔════════════════════════════════════════╗');
    print('║   Welcome back, $username! 👋         ║');
    print('╚════════════════════════════════════════╝');
  }

  void displaySummary(Map<String, dynamic> data) {
    print('\n📊 Dashboard Summary:');
    print('┌────────────────────────────────┐');
    data.forEach((key, value) {
      print('│ ${key.padRight(20)}: ${value.toString().padLeft(8)} │');
    });
    print('└────────────────────────────────┘');
  }

  void displayNotification(String message, {String type = 'info'}) {
    var icon = type == 'success'
        ? '✓'
        : type == 'error'
        ? '✗'
        : 'ℹ';
    print('$icon $message');
  }
}

// Example usage demonstrating view-only logic
void main() {
  print('=== MVC View Examples ===');

  // Example 1: Counter View
  print('\n--- Counter View Demo ---');
  var counterView = CounterView();
  counterView.displayCount(0);
  counterView.displayIncrementMessage();
  counterView.displayCount(1);
  counterView.showMenu();

  // Example 2: User View
  print('\n--- User View Demo ---');
  var userView = UserView();
  userView.displayUser('John Doe', 'john@example.com', 30);
  userView.displayUpdateSuccess('Name');
  userView.displayError('Invalid email format');

  // Example 3: TodoList View
  print('\n--- TodoList View Demo ---');
  var todoView = TodoListView();

  var todos = [
    TodoItemDisplay('1', 'Learn Dart', true),
    TodoItemDisplay('2', 'Build an app', false),
    TodoItemDisplay('3', 'Study MVC', false),
  ];

  todoView.displayTodos(todos);
  todoView.displayStats(3, 1, 2);
  todoView.displayAddSuccess('Write tests');

  // Example 4: Dashboard View
  print('\n--- Dashboard View Demo ---');
  var dashboardView = DashboardView();
  dashboardView.displayWelcome('Alice');
  dashboardView.displaySummary({
    'Total Tasks': 10,
    'Completed': 7,
    'In Progress': 3,
    'Messages': 5,
  });
  dashboardView.displayNotification('New message received!', type: 'info');
  dashboardView.displayNotification('Task completed!', type: 'success');
}

