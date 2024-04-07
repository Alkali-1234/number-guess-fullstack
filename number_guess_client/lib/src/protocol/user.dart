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

/// User Data
abstract class User extends _i1.SerializableEntity {
  User._({
    this.id,
    required this.uid,
    required this.score,
    required this.gamesHistory,
  });

  factory User({
    int? id,
    required int uid,
    required int score,
    required List<_i2.Game> gamesHistory,
  }) = _UserImpl;

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      uid: serializationManager.deserialize<int>(jsonSerialization['uid']),
      score: serializationManager.deserialize<int>(jsonSerialization['score']),
      gamesHistory: serializationManager
          .deserialize<List<_i2.Game>>(jsonSerialization['gamesHistory']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int uid;

  int score;

  List<_i2.Game> gamesHistory;

  User copyWith({
    int? id,
    int? uid,
    int? score,
    List<_i2.Game>? gamesHistory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'uid': uid,
      'score': score,
      'gamesHistory': gamesHistory.toJson(valueToJson: (v) => v.toJson()),
    };
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required int uid,
    required int score,
    required List<_i2.Game> gamesHistory,
  }) : super._(
          id: id,
          uid: uid,
          score: score,
          gamesHistory: gamesHistory,
        );

  @override
  User copyWith({
    Object? id = _Undefined,
    int? uid,
    int? score,
    List<_i2.Game>? gamesHistory,
  }) {
    return User(
      id: id is int? ? id : this.id,
      uid: uid ?? this.uid,
      score: score ?? this.score,
      gamesHistory: gamesHistory ?? this.gamesHistory.clone(),
    );
  }
}
