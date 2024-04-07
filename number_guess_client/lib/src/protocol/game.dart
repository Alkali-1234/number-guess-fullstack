/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

/// Game that is played by the user
abstract class Game extends _i1.SerializableEntity {
  Game._({
    required this.timestamp,
    required this.number,
    required this.guesses,
  });

  factory Game({
    required DateTime timestamp,
    required int number,
    required List<_i2.Guess> guesses,
  }) = _GameImpl;

  factory Game.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Game(
      timestamp: serializationManager
          .deserialize<DateTime>(jsonSerialization['timestamp']),
      number:
          serializationManager.deserialize<int>(jsonSerialization['number']),
      guesses: serializationManager
          .deserialize<List<_i2.Guess>>(jsonSerialization['guesses']),
    );
  }

  DateTime timestamp;

  int number;

  List<_i2.Guess> guesses;

  Game copyWith({
    DateTime? timestamp,
    int? number,
    List<_i2.Guess>? guesses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toJson(),
      'number': number,
      'guesses': guesses.toJson(valueToJson: (v) => v.toJson()),
    };
  }
}

class _GameImpl extends Game {
  _GameImpl({
    required DateTime timestamp,
    required int number,
    required List<_i2.Guess> guesses,
  }) : super._(
          timestamp: timestamp,
          number: number,
          guesses: guesses,
        );

  @override
  Game copyWith({
    DateTime? timestamp,
    int? number,
    List<_i2.Guess>? guesses,
  }) {
    return Game(
      timestamp: timestamp ?? this.timestamp,
      number: number ?? this.number,
      guesses: guesses ?? this.guesses.clone(),
    );
  }
}
