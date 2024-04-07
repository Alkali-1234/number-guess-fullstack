import "package:flutter/material.dart";
import "package:number_guess_client/number_guess_client.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/user_info.dart";
import "../data/user_stats.dart";

class GamesHistoryDisplay extends ConsumerWidget {
  const GamesHistoryDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    final userStats = ref.watch(userStatsNotifierProvider);
    final userInfo = ref.watch(userInfoProvider);
    return Dialog(
      backgroundColor: theme.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Games History', style: textTheme.displayMedium),
              const SizedBox(height: 16),
              if (userInfo == null) Text('Please sign in to see your games history.', style: textTheme.displaySmall),
              for (Game game in userStats?.gamesHistory.reversed ?? [])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      colorScheme: theme,
                      textTheme: textTheme,
                    ),
                    child: ExpansionTile(childrenPadding: const EdgeInsets.all(16), expandedAlignment: Alignment.topLeft, expandedCrossAxisAlignment: CrossAxisAlignment.start, collapsedIconColor: theme.onBackground, collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), collapsedBackgroundColor: theme.secondary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: theme.tertiary)), backgroundColor: theme.secondary, iconColor: theme.onBackground, title: Text(game.timestamp.toString(), style: textTheme.displaySmall), children: [
                      Text('Guesses made:', style: textTheme.displaySmall),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          for (int i = 0; i < game.guesses.length; i++)
                            Chip(
                                side: BorderSide.none,
                                shape: const StadiumBorder(),
                                //* Iterating background color,
                                backgroundColor: i + 1 == game.guesses.length
                                    ? Colors.green
                                    : [
                                        Colors.red,
                                        Colors.green,
                                        Colors.yellow,
                                        Colors.blue,
                                        Colors.purple,
                                        Colors.orange,
                                      ][i % 6]
                                        .withOpacity(0.25),
                                label: Text(game.guesses[i].number.toString(),
                                    style: textTheme.displaySmall!.copyWith(
                                      fontWeight: i + 1 == game.guesses.length ? FontWeight.bold : FontWeight.normal,
                                    ))),
                        ],
                      )
                    ]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
