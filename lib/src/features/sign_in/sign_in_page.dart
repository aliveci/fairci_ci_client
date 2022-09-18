import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(80, 20)),
              onPressed: () async {
                // Obtain shared preferences.
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isHost', true);
              },
              child: const Text('Host'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(80, 20)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isHost', false);
              },
              child: const Text('Client'),
            ),
          ],
        ),
      ),
    );
  }
}
