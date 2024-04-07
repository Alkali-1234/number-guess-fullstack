import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user_stats.dart';
import 'games_history_display.dart';

class StatisticDisplay extends ConsumerWidget {
  const StatisticDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    final userStats = ref.watch(userStatsNotifierProvider);
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          statBox("Score", userStats?.score.toString() ?? "0", theme, textTheme),
          const SizedBox(width: 16),
          statBox("Games", userStats?.gamesHistory.length.toString() ?? "0", theme, textTheme),
          const SizedBox(width: 16),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () => showDialog(context: context, builder: (c) => const GamesHistoryDisplay()),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: theme.secondary,
                side: BorderSide(color: theme.tertiary, width: 1),
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                padding: const EdgeInsets.all(8),
              ),
              child: Text("Games History ...", style: textTheme.displaySmall),
            ),
          ),
        ],
      ),
    );
  }

  Widget statBox(String title, String value, ColorScheme theme, TextTheme textTheme) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: textTheme.displaySmall),
          const SizedBox(height: 8),
          Text(value, style: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
