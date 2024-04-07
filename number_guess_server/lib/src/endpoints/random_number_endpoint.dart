import 'package:number_guess_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'dart:math';

int guesses = 3;
int randomNumber = Random().nextInt(100);

List<Guess> guessesList = [];

class RandomNumberEndpoint extends Endpoint {
  Future<int> generateRandomNumber(Session session) async {
    return Random().nextInt(100);
  }

  @override
  Future<void> streamOpened(StreamingSession session) async {
    // Initialize variables
    guessesList = [];
    randomNumber = Random().nextInt(100);
    session.log("New game opened, the number is $randomNumber");
    session.log("User id: ${await session.auth.authenticatedUserId}");
    session.log("User auth status: ${await session.isUserSignedIn}");
    // Listen for messages sent by the user
    session.messages.addListener("guess_number_${await session.auth.authenticatedUserId}", (message) {
      sendStreamMessage(session, message);
    });
  }

  /// Handles messages sent to the user
  @override
  Future<void> handleStreamMessage(StreamingSession session, SerializableEntity message) async {
    session.log('Received message: $message');
    if (message is Guess) {
      // Add the guess to the list
      guessesList.add(message);
      if (message.number == randomNumber) {
        //* Send the result to the user
        sendStreamMessage(session, GuessResult(result: GuessResultTypes.Correct));

        //* Check authentication
        final authUid = await session.auth.authenticatedUserId;
        if (authUid == null) {
          session.log('User not authenticated, database not updated');
          return;
        }

        //* Find the user in the database
        var user = await User.db.findFirstRow(session, where: (p0) => p0.uid.equals(authUid));
        if (user == null) {
          session.log('User not found, database not updated');
          return;
        }

        //* Update the user's statistics
        user.score += (1000 / guessesList.length).round();
        user.gamesHistory.add(Game(
          timestamp: DateTime.now(),
          number: randomNumber,
          guesses: guessesList,
        ));

        //* Update the user in the database
        await User.db.updateRow(session, user);

        //* Send the user the updated statistics
        session.messages.postMessage('user_stat_$authUid', message);
      }

      if (message.number > randomNumber) {
        sendStreamMessage(session, GuessResult(result: GuessResultTypes.Higher));
      }

      if (message.number < randomNumber) {
        sendStreamMessage(session, GuessResult(result: GuessResultTypes.Lower));
      }
    }

    if (message is Guess == false) {
      session.close(error: 'Invalid message type');
    }
  }

  /// Handles the stream being closed
  @override
  Future<void> streamClosed(StreamingSession session) async {
    session.log('Game closed');
  }
}
