import 'package:number_guess_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

User? user;

/// Handles user statistics, uses streams to keep the user updated
class GetUserStatsEndpoint extends Endpoint {
  Future<User> getUserStats(Session session) async {
    final authUid = await session.auth.authenticatedUserId;
    if (authUid == null) {
      session.close(error: 'Not authenticated');
    }
    //* Check if the user row exists
    user = await User.db.findFirstRow(session, where: (p0) => p0.uid.equals(authUid));
    if (user == null) {
      //* If the user row does not exist, create a new one
      await User.db.insertRow(
          session,
          User(
            uid: authUid!,
            score: 0,
            gamesHistory: [],
          ));
    }
    //* Get the user row
    user = await User.db.findFirstRow(session, where: (p0) => p0.uid.equals(authUid));
    return user!;
  }

  @override
  Future<void> streamOpened(StreamingSession session) async {
    final authUid = await session.auth.authenticatedUserId;

    /// Check if the user is authenticated
    if (authUid == null) {
      session.close(error: 'Not authenticated');
    }

    /// Get the user stats upon connecting
    sendStreamMessage(session, await getUserStats(session));

    /// Listen for messages when the user stats change
    session.messages.addListener('user_stat_$authUid', (message) {
      sendStreamMessage(session, message);
    });
  }

  /// Handles messages, and updates the user on the user stats from the database
  @override
  Future<void> handleStreamMessage(StreamingSession session, SerializableEntity message) async {
    // Check for stop message
    // Closes the stream if the user sends a stop_stream message
    if (message is Message) {
      if (message.message == 'stop_stream') {
        await sendStreamMessage(session, Message(message: 'stop_stream'));
        session.close();
        return;
      }
    }

    final authUid = await session.auth.authenticatedUserId;

    /// Check if the user is authenticated
    if (authUid == null) {
      session.close(error: 'Not authenticated');
    }

    /// Sends the user the updated user stats
    sendStreamMessage(session, await getUserStats(session));
  }
}
