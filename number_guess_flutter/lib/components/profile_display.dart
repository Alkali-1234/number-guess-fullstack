import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_guess_flutter/data/user_info.dart';
import 'package:number_guess_flutter/data/user_stats.dart';
import 'package:number_guess_flutter/logger.dart';
import '../service/serverpod_client.dart';

class ProfileDisplay extends ConsumerWidget {
  const ProfileDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    final userInfo = ref.watch(userInfoProvider);
    return Dialog(
      backgroundColor: theme.background,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_circle_rounded, color: theme.onBackground, size: 48),
            const SizedBox(height: 16),
            Text('Profile', style: textTheme.displayMedium),
            const SizedBox(height: 16),
            Text('Username: ${userInfo?.userName ?? "Guest"}', style: textTheme.displaySmall),
            const SizedBox(height: 8),
            Text('Email: ${userInfo?.email ?? "No Email"}', style: textTheme.displaySmall),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), backgroundColor: Colors.red),
                onPressed: () async {
                  Navigator.of(context).pop();
                  ref.read(userInfoProvider.notifier).state = null;
                  await stopUserStatsStream();
                  await sessionManager.signOut();
                  logger.i('User signed out');
                },
                child: Text('Sign out', style: textTheme.displaySmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
