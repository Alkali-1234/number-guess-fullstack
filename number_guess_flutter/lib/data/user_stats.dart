import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_guess_client/number_guess_client.dart';

import '../logger.dart';
import '../service/serverpod_client.dart';

/// User stats notifier
class UserStatsNotifier extends Notifier<User?> {
  // Future<void> initialize() async {
  //   state = await client.getUserStats.getUserStats();
  //   logger.i('User stats: $state');
  // }

  Future<void> startUserStatsStream() async {
    logger.i('Starting user stats stream');
    await client.openStreamingConnection();
    final user = await client.getUserStats.getUserStats();
    state = user;
    logger.i('User stats: $user');

    // Refresh
    client.getUserStats.resetStream();
    await sessionManager.refreshSession();

    await for (final message in client.getUserStats.stream) {
      // Closes the stream upon request
      if (message is Message) {
        if (message.message == 'stop_stream') {
          state = null;
          return;
        }
      }
      // Fetch the user stats
      final user = await client.getUserStats.getUserStats();
      state = user;
      logger.i('User stats: $user');
    }
    logger.i('User stats stream closed');
  }

  void updateUserStats(User user) {
    state = user;
  }

  @override
  User? build() {
    return null;
  }
}

/// Provider for the user stats
final userStatsNotifierProvider = NotifierProvider<UserStatsNotifier, User?>(UserStatsNotifier.new);

// Stop stream
Future<void> stopUserStatsStream() async {
  await client.openStreamingConnection();
  await client.getUserStats.sendStreamMessage(Message(message: 'stop_stream'));
  logger.i("Sent stop_stream message to server");
}

// // Restart the stream
// Future<void> restartUserStatsStream(WidgetRef ref) async {
//   await ref.read(userStatsStreamProvider).;
// }
