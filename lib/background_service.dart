import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background task executed: $task");

    // Show notification
    await NotificationService.showNotification(
        "Background Task", "Task executed successfully");

    return Future.value(true);
  });
}

void initializeBackgroundService() {
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  Workmanager().registerPeriodicTask(
    "1",
    "simplePeriodicTask",
    frequency: Duration(minutes: 15),
  );
}
