import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:number_guess_flutter/data/user_info.dart";
import "package:number_guess_flutter/logger.dart";
import "package:number_guess_flutter/styles.dart";
import "package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart";

import "../data/user_stats.dart";
import "../service/serverpod_client.dart";

final validatingEmailProvider = StateProvider<bool>((ref) => false);

class SignUpDialog extends ConsumerWidget {
  SignUpDialog({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _validationCodeController = TextEditingController();

  late final EmailAuthController _authController = EmailAuthController(client.modules.auth);

  /// Signs up the user with the given email and password.
  Future<void> _signUp(BuildContext context, WidgetRef ref) async {
    // Check empty fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _passwordConfirmController.text.isEmpty || _usernameController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Sign up failed', style: Theme.of(context).textTheme.displaySmall),
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
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;

    // Check if passwords match
    if (password != passwordConfirm) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Sign up failed', style: Theme.of(context).textTheme.displaySmall),
                content: Text('Passwords do not match.', style: Theme.of(context).textTheme.displaySmall),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK', style: Theme.of(context).textTheme.displaySmall),
                  ),
                ],
              ));
      return;
    }

    // Request the account creation
    final result = await _authController.createAccountRequest(username, email, password);
    if (result == false) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Sign up failed', style: Theme.of(context).textTheme.displaySmall),
                  content: Text('Sign up failed. Please check your email and password and try again.', style: Theme.of(context).textTheme.displaySmall),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK', style: Theme.of(context).textTheme.displaySmall),
                    ),
                  ],
                ));
      }
      return;
    }

    // Validate account creation
    ref.read(validatingEmailProvider.notifier).state = true;
  }

  /// Validates the email address.
  /// This is used to validate the email address after the user has clicked the link in the email.
  Future<void> _validateEmail(BuildContext context, WidgetRef ref) async {
    final email = _emailController.text;
    final code = _validationCodeController.text;
    if (email.isEmpty || code.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Validation failed', style: Theme.of(context).textTheme.displaySmall),
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

    final result = await _authController.validateAccount(email, code);
    if (result == null) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Validation failed', style: Theme.of(context).textTheme.displaySmall),
                  content: Text('Validation failed. Please check your email and code and try again.', style: Theme.of(context).textTheme.displaySmall),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK', style: Theme.of(context).textTheme.displaySmall),
                    ),
                  ],
                ));
      }
      return;
    }

    // Update user info
    ref.read(userInfoProvider.notifier).state = result;
    // Start the user stats listener
    ref.read(userStatsNotifierProvider.notifier).startUserStatsStream();
    logger.i('User validated: ${result.email}');
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validatingEmail = ref.watch(validatingEmailProvider);
    if (validatingEmail == false) {
      return Dialog(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Sign up', style: Theme.of(context).textTheme.displayMedium),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: _usernameController,
                  decoration: BaseTextInputStyle(Theme.of(context).colorScheme, Theme.of(context).textTheme).inputDecoration.copyWith(
                        labelText: 'Username',
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: _emailController,
                  decoration: BaseTextInputStyle(Theme.of(context).colorScheme, Theme.of(context).textTheme).inputDecoration.copyWith(
                        labelText: 'Email',
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: Theme.of(context).textTheme.displaySmall,
                  obscureText: true,
                  controller: _passwordController,
                  decoration: BaseTextInputStyle(Theme.of(context).colorScheme, Theme.of(context).textTheme).inputDecoration.copyWith(
                        labelText: 'Password',
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: Theme.of(context).textTheme.displaySmall,
                  obscureText: true,
                  controller: _passwordConfirmController,
                  decoration: BaseTextInputStyle(Theme.of(context).colorScheme, Theme.of(context).textTheme).inputDecoration.copyWith(
                        labelText: 'Confirm password',
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _signUp(context, ref),
                    child: Text('Sign up', style: Theme.of(context).textTheme.displaySmall),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Dialog(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Validate Email', style: Theme.of(context).textTheme.displayMedium),
              ),
              Padding(padding: const EdgeInsets.all(16), child: Text('Please check your email and click the link to validate your account.', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: _validationCodeController,
                  decoration: BaseTextInputStyle(Theme.of(context).colorScheme, Theme.of(context).textTheme).inputDecoration.copyWith(
                        labelText: 'Code',
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _validateEmail(context, ref),
                  child: Text('Validate Email', style: Theme.of(context).textTheme.displaySmall),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
