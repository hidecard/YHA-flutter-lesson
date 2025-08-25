import 'package:flutter/material.dart';

// Main app entry point
void main() {
  runApp(const TaskTrackerApp());
}

// App widget with theme
class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Blue buttons
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      home: const TaskTrackerScreen(),
    );
  }
}

// Task model
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

// Main screen with state management
class TaskTrackerScreen extends StatefulWidget {
  const TaskTrackerScreen({super.key});

  @override
  _TaskTrackerScreenState createState() => _TaskTrackerScreenState();
}

class _TaskTrackerScreenState extends State<TaskTrackerScreen> {
  // State variables
  List<Task> _tasks = []; // List of tasks
  final TextEditingController _controller = TextEditingController();

  // Add a new task
  void _addTask(String name) {
    if (name.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: name));
        _controller.clear(); // Clear input
      });
    }
  }

  // Toggle task completion
  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  // Clear all tasks
  void _clearTasks() {
    setState(() {
      _tasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YHA Lesson'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _clearTasks,
            tooltip: 'Clear All Tasks',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Your Tasks',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Task Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Form(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Task',
                        hintText: 'Enter task name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Task cannot be empty';
                        }
                        return null;
                      },
                      onFieldSubmitted: _addTask, // Add task on Enter
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _addTask(_controller.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task Added!')),
                        );
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
          // Task List
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('No tasks yet!', style: TextStyle(fontSize: 18)))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: _tasks[index],
                        onToggle: () => _toggleTask(index),
                      );
                    },
                  ),
          ),
          // Status Bar
          StatusBar(tasks: _tasks),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up controller
    super.dispose();
  }
}

// Task card widget (stateless, uses parent state)
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const TaskCard({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: task.isCompleted ? Colors.green[100] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 4)],
      ),
      child: GestureDetector(
        onTap: onToggle, // Toggle on tap
        child: Row(
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (value) => onToggle(),
            ),
            Expanded(
              child: Text(
                task.name,
                style: TextStyle(
                  fontSize: 16,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Status bar widget (stateless, uses parent state)
class StatusBar extends StatelessWidget {
  final List<Task> tasks;

  const StatusBar({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(12.0),
      color: Colors.blue[50],
      child: Text(
        'Completed: $completedTasks / ${tasks.length}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}