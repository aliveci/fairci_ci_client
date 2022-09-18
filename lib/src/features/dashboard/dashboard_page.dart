import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:process_run/shell.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
