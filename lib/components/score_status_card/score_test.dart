import 'dart:async';
import 'package:flutter/material.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ScoreTest extends StatefulWidget {
  @override
  _ScoreTestState createState() => _ScoreTestState();
}

class _ScoreTestState extends State<ScoreTest> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the local notifications plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // Initialize background fetch
    initBackgroundFetch();
  }

  @override
  void dispose() {
    // Clean up resources
    _timer!.cancel();
    super.dispose();
  }

  void initBackgroundFetch() {
    BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 1, // Fetch interval in minutes
        stopOnTerminate:
            false, // Continue running task even if the app is terminated
        enableHeadless: true, // Enable headless task execution
      ),
      (String taskId) async {
        // Task logic
        showNotification();
        BackgroundFetch.finish(taskId);
      },
    );
    // Start background fetch
    BackgroundFetch.start();
    _timer = Timer(Duration(minutes: 1), () {
      BackgroundFetch.stop();
    });
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      'Background Task Notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      0,
      'Background Task Completed',
      'One minute has elapsed in the background',
      platformChannelSpecifics,
      payload: 'background_task',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Execution Demo'),
      ),
      body: Center(
        child: Text('App is running in the background.'),
      ),
    );
  }
}
