import 'package:flutter/material.dart';
import 'background_service.dart';
import 'notification_service.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  await NotificationService.initialize();

  // Initialize background service
  initializeBackgroundService();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> executedTasks = [];

  @override
  void initState() {
    super.initState();

    // Simulate UI update on background task (for demo)
    Workmanager().registerOneOffTask(
      "2",
      "initialDemoTask",
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );

    // Here we can listen to tasks in real app using Streams or local storage
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Background + Notification Example")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    executedTasks.add(
                        "Manual task executed at ${DateTime.now()}");
                  });
                },
                child: Text("Run Manual Task"),
              ),
              SizedBox(height: 20),
              Text(
                "Executed Tasks:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: executedTasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(executedTasks[index]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
