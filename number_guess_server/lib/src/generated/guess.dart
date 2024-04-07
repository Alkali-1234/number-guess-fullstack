/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// The guess sent by the client
abstract class Guess extends _i1.SerializableEntity {
  Guess._({required this.number});

  factory Guess({required int number}) = _GuessImpl;

  factory Guess.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Guess(
        number:
            serializationManager.deserialize<int>(jsonSerialization['number']));
  }

  int number;

  Guess copyWith({int? number});
  @override
  Map<String, dynamic> toJson() {
    return {'number': number};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'number': number};
  }
}

class _GuessImpl extends Guess {
  _GuessImpl({required int number}) : super._(number: number);

  @override
  Guess copyWith({int? number}) {
    return Guess(number: number ?? this.number);
  }
}
