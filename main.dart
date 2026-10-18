import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int count = 0;

  @override
  void initState() {
    super.initState();
    analytics.logAppOpen();
  }

  Future<void> _onPressed() async {
    setState(() => count++);
    await analytics.logEvent(
      name: 'button_click',
      parameters: {'count': count},
    );
  }

  @override
  Widget build(BuildContext context) {
    final options = Firebase.app().options;

    return Scaffold(
      appBar: AppBar(
        title: const Text('w12 Firebase Test'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 12),
            const Text(
              'Firebase Connected Successfully!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Project: ${options.projectId}'),
            const SizedBox(height: 24),
            Text('Button clicked: $count', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _onPressed,
              child: const Text('Send Analytics Event'),
            ),
          ],
        ),
      ),
    );
  }
}