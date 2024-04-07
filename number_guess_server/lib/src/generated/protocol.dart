/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/module.dart' as _i3;
import 'example.dart' as _i4;
import 'game.dart' as _i5;
import 'guess.dart' as _i6;
import 'guess_result.dart' as _i7;
import 'guess_result_types.dart' as _i8;
import 'message.dart' as _i9;
import 'user.dart' as _i10;
import 'protocol.dart' as _i11;
export 'example.dart';
export 'game.dart';
export 'guess.dart';
export 'guess_result.dart';
export 'guess_result_types.dart';
export 'message.dart';
export 'user.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'number_guess',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'uid',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'gamesHistory',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:Game>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i4.Example) {
      return _i4.Example.fromJson(data, this) as T;
    }
    if (t == _i5.Game) {
      return _i5.Game.fromJson(data, this) as T;
    }
    if (t == _i6.Guess) {
      return _i6.Guess.fromJson(data, this) as T;
    }
    if (t == _i7.GuessResult) {
      return _i7.GuessResult.fromJson(data, this) as T;
    }
    if (t == _i8.GuessResultTypes) {
      return _i8.GuessResultTypes.fromJson(data) as T;
    }
    if (t == _i9.Message) {
      return _i9.Message.fromJson(data, this) as T;
    }
    if (t == _i10.User) {
      return _i10.User.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i4.Example?>()) {
      return (data != null ? _i4.Example.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.Game?>()) {
      return (data != null ? _i5.Game.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.Guess?>()) {
      return (data != null ? _i6.Guess.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.GuessResult?>()) {
      return (data != null ? _i7.GuessResult.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.GuessResultTypes?>()) {
      return (data != null ? _i8.GuessResultTypes.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Message?>()) {
      return (data != null ? _i9.Message.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i10.User?>()) {
      return (data != null ? _i10.User.fromJson(data, this) : null) as T;
    }
    if (t == List<_i11.Guess>) {
      return (data as List).map((e) => deserialize<_i11.Guess>(e)).toList()
          as dynamic;
    }
    if (t == List<_i11.Game>) {
      return (data as List).map((e) => deserialize<_i11.Game>(e)).toList()
          as dynamic;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i4.Example) {
      return 'Example';
    }
    if (data is _i5.Game) {
      return 'Game';
    }
    if (data is _i6.Guess) {
      return 'Guess';
    }
    if (data is _i7.GuessResult) {
      return 'GuessResult';
    }
    if (data is _i8.GuessResultTypes) {
      return 'GuessResultTypes';
    }
    if (data is _i9.Message) {
      return 'Message';
    }
    if (data is _i10.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i4.Example>(data['data']);
    }
    if (data['className'] == 'Game') {
      return deserialize<_i5.Game>(data['data']);
    }
    if (data['className'] == 'Guess') {
      return deserialize<_i6.Guess>(data['data']);
    }
    if (data['className'] == 'GuessResult') {
      return deserialize<_i7.GuessResult>(data['data']);
    }
    if (data['className'] == 'GuessResultTypes') {
      return deserialize<_i8.GuessResultTypes>(data['data']);
    }
    if (data['className'] == 'Message') {
      return deserialize<_i9.Message>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i10.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i10.User:
        return _i10.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'number_guess';
}
