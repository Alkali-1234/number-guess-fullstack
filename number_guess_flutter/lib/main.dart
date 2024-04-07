import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_guess_client/number_guess_client.dart';
import 'package:flutter/material.dart';
import 'package:number_guess_flutter/components/profile_display.dart';
import 'package:number_guess_flutter/constants.dart';
import 'components/sign_in_dialog.dart';
import 'components/statistic_display.dart';
import 'data/user_info.dart';
import 'logger.dart';
import 'service/serverpod_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpodClient();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessing Game',
      theme: darkTheme,
      home: ProviderScope(child: HomePage()),
    );
  }
}

//* Connect to server and get the current game state

enum GameState {
  none,
  playing,
  won,
  lost
}

final gameStateProvider = StateProvider((ref) => GameState.none);
final guessResultProvider = StateProvider<GuessResultTypes?>((ref) => null);
final guessNumberProvider = StateProvider<int?>((ref) => null);

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final guessController = TextEditingController();

  ///* Function to start a new game
  Future<void> startGame(WidgetRef ref) async {
    logger.i("User auth status: ${sessionManager.isSignedIn}");
    await client.openStreamingConnection();
    // await client.updateStreamingConnectionAuthenticationKey(await client.authenticationKeyManager!.get());
    ref.read(gameStateProvider.notifier).state = GameState.playing;

    client.randomNumber.resetStream();

    /// Listen for messages sent by the server
    await for (var message in client.randomNumber.stream) {
      handleMessage(ref, message);
      if (message is GuessResult && message.result == GuessResultTypes.Correct) {
        logger.i('Game won, stopping stream.');
        break;
      }
    }
  }

  /// Send a guess to the server
  Future<void> sendGuess(WidgetRef ref, BuildContext context) async {
    if (client.streamingConnectionStatus != StreamingConnectionStatus.connected) {
      handleError('Not connected to server', context);
      logger.e('Not connected to server');
      return;
    }
    if (guessController.text.isEmpty) {
      handleError('Please enter a number', context);
      return;
    }
    ref.read(guessNumberProvider.notifier).state = int.parse(guessController.text);
    final guess = Guess(number: int.parse(guessController.text));
    client.randomNumber.sendStreamMessage(guess);
  }

  /// Handle messages sent by the server
  void handleMessage(WidgetRef ref, SerializableEntity message) {
    if (message is GuessResult) {
      logger.i('Received guess result: ${message.result}');
      ref.read(guessResultProvider.notifier).state = message.result;
      if (message.result == GuessResultTypes.Correct) {
        ref.read(gameStateProvider.notifier).state = GameState.won;
      }
    }
  }

  void handleError(String error, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Error', style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold)),
              content: Text(error, style: Theme.of(context).textTheme.displaySmall),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('OK', style: Theme.of(context).textTheme.displaySmall)),
              ],
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    final gameState = ref.watch(gameStateProvider);
    final guessResult = ref.watch(guessResultProvider);
    final guess = ref.watch(guessNumberProvider);
    final userInfo = ref.watch(userInfoProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 300,
        leading: userInfo == null
            ? Row(
                children: [
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.account_circle_rounded, color: theme.onBackground),
                    onPressed: () => showDialog(context: context, builder: (context) => SignInDialog()),
                  ),
                ],
              )
            : Row(
                children: [
                  const SizedBox(width: 8),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => showDialog(context: context, builder: (c) => const ProfileDisplay()),
                      child: Text(userInfo.userName, style: textTheme.displaySmall)),
                ],
              ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Guess result
            if (guessResult != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: guessResult == GuessResultTypes.Correct ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (guessResult == GuessResultTypes.Higher) Text('Your guess was $guess. Go Lower!', style: textTheme.displayMedium),
                    if (guessResult == GuessResultTypes.Lower) Text('Your guess was $guess. Go Higher!', style: textTheme.displayMedium),
                    if (guessResult == GuessResultTypes.Correct)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Your guess was $guess. Correct!', style: textTheme.displayMedium),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: Icon(Icons.close, color: theme.onBackground),
                            onPressed: () => ref.read(guessResultProvider.notifier).state = null,
                          ),
                        ],
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            /// Guesing input
            if (gameState == GameState.playing)
              SizedBox(
                width: 300,
                child: TextField(
                  controller: guessController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: textTheme.displaySmall,
                  cursorColor: theme.onBackground,
                  decoration: InputDecoration(
                    hintText: '1-100',
                    hintStyle: textTheme.displaySmall!.copyWith(color: theme.onBackground.withOpacity(0.5)),
                    labelStyle: textTheme.displaySmall,
                    fillColor: theme.primary,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            /// Buttons
            if (gameState != GameState.playing)
              Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colors.blue,
                        Colors.deepPurple,
                      ]),
                      borderRadius: BorderRadius.circular(100)),
                  child: ElevatedButton(style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 24), backgroundColor: Colors.transparent, side: BorderSide(color: theme.secondary), shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent), onPressed: () => startGame(ref), child: Text('Play', style: textTheme.displayMedium))),
            if (gameState == GameState.playing) ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, side: BorderSide(color: theme.secondary), shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent), onPressed: () => sendGuess(ref, context), child: Text('Guess', style: textTheme.displaySmall)),

            // StatisticDisplay
            const SizedBox(height: 16),
            const StatisticDisplay(),
          ],
        ),
      ),
    );
  }
}
