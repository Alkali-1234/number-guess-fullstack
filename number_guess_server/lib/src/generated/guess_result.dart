/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;

/// The guess result sent by the server
abstract class GuessResult extends _i1.SerializableEntity {
  GuessResult._({required this.result});

  factory GuessResult({required _i2.GuessResultTypes result}) =
      _GuessResultImpl;

  factory GuessResult.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return GuessResult(
        result: serializationManager
            .deserialize<_i2.GuessResultTypes>(jsonSerialization['result']));
  }

  _i2.GuessResultTypes result;

  GuessResult copyWith({_i2.GuessResultTypes? result});
  @override
  Map<String, dynamic> toJson() {
    return {'result': result.toJson()};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'result': result.toJson()};
  }
}

class _GuessResultImpl extends GuessResult {
  _GuessResultImpl({required _i2.GuessResultTypes result})
      : super._(result: result);

  @override
  GuessResult copyWith({_i2.GuessResultTypes? result}) {
    return GuessResult(result: result ?? this.result);
  }
}
