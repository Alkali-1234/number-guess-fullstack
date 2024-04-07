import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:number_guess_flutter/data/user_stats.dart";
import "package:number_guess_flutter/styles.dart";
import "package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart";
import "../data/user_info.dart";
import '../service/serverpod_client.dart';
import "sign_up_dialog.dart";

class SignInDialog extends ConsumerWidget {
  SignInDialog({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final EmailAuthController _authController = EmailAuthController(client.modules.auth);

  Future<void> _signIn(BuildContext context, WidgetRef ref) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Sign in failed', style: Theme.of(context).textTheme.displaySmall),
                content: Text('Please fill in all fields.', style: Theme.of(context).textTheme.displaySmall),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK', style: Theme.of(context).textTheme.displaySmall),
                  ),
                ],
              ));
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    final result = await _authController.signIn(email, password);
    if (result == null) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Sign in failed', style: Theme.of(context).textTheme.displaySmall),
                  content: Text('Sign in failed. Please check your email and password and try again.', style: Theme.of(context).textTheme.displaySmall),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK', style: Theme.of(context).textTheme.displaySmall),
                    ),
                  ],
                ));
      }
    }
    //* Update authentication status
    // client.updateStreamingConnectionAuthenticationKey(await client.authenticationKeyManager!.get());
    //* Set the user info
    ref.read(userInfoProvider.notifier).state = result;
    //* Run the user stats listener
    // ref.read(userStatsNotifierProvider.notifier).initialize();
    ref.read(userStatsNotifierProvider.notifier).startUserStatsStream();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: theme.background,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_circle, size: 48, color: theme.onBackground),
            const SizedBox(height: 16),
            Text(
              "Sign In",
              style: textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: textTheme.displaySmall,
                cursorColor: theme.onBackground,
                decoration: BaseTextInputStyle(theme, textTheme).inputDecoration.copyWith(
                      hintText: 'Email',
                    ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                style: textTheme.displaySmall,
                cursorColor: theme.onBackground,
                decoration: BaseTextInputStyle(theme, textTheme).inputDecoration.copyWith(
                      hintText: 'Password',
                    ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _signIn(context, ref),
                    child: Text('Sign In', style: textTheme.displaySmall))),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => SignUpDialog());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: theme.tertiary),
                ),
                child: Text('Create account', style: textTheme.displaySmall),
              ),
            )
          ],
        ),
      ),
    );
  }
}
