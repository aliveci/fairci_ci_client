import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientDashboardPage extends StatefulWidget {
  const ClientDashboardPage({super.key});

  @override
  State<ClientDashboardPage> createState() => _ClientDashboardPageState();
}

class _ClientDashboardPageState extends State<ClientDashboardPage> {
  List<String> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fair CI - Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.lightGreen,
              size: 40,
            ),
            onPressed: () async {
              var controller = ShellLinesController();
              var shell = Shell(stdout: controller.sink, verbose: false);
              controller.stream.listen((event) {
                setState(() {
                  results.add(event);
                });
              });
              try {
                await shell.run('ping www.vmware.com');
              } on ShellException catch (_) {
                // We might get a shell exception
              }
            },
          ),
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('isHost');
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final singleResult = results[index];
          return Text(singleResult);
        },
      ),
    );
  }
}
