import 'package:fairci_ci_client/src/features/dashboard/client_dashboard_page.dart';
import 'package:fairci_ci_client/src/features/dashboard/host_dashboard_page.dart';
import 'package:fairci_ci_client/src/features/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = FutureProvider<bool?>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  final bool? isHost = prefs.getBool('isHost');
  return isHost;
});

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(authProvider);
    return future.when(
        data: (data) {
          if (data == null) {
            return const SignInPage();
          }
          if (data) {
            return const HostDashboardPage();
          }
          return const ClientDashboardPage();
        },
        error: ((error, stackTrace) => const Text('Error')),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}
