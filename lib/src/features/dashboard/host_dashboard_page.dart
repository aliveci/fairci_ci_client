import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostDashboardPage extends StatelessWidget {
  const HostDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Host dashboard'),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('isHost');
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
    );
  }
}
