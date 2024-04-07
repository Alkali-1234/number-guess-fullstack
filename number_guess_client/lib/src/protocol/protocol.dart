/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'example.dart' as _i2;
import 'game.dart' as _i3;
import 'guess.dart' as _i4;
import 'guess_result.dart' as _i5;
import 'guess_result_types.dart' as _i6;
import 'message.dart' as _i7;
import 'user.dart' as _i8;
import 'protocol.dart' as _i9;
import 'package:serverpod_auth_client/module.dart' as _i10;
export 'example.dart';
export 'game.dart';
export 'guess.dart';
export 'guess_result.dart';
export 'guess_result_types.dart';
export 'message.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Example) {
      return _i2.Example.fromJson(data, this) as T;
    }
    if (t == _i3.Game) {
      return _i3.Game.fromJson(data, this) as T;
    }
    if (t == _i4.Guess) {
      return _i4.Guess.fromJson(data, this) as T;
    }
    if (t == _i5.GuessResult) {
      return _i5.GuessResult.fromJson(data, this) as T;
    }
    if (t == _i6.GuessResultTypes) {
      return _i6.GuessResultTypes.fromJson(data) as T;
    }
    if (t == _i7.Message) {
      return _i7.Message.fromJson(data, this) as T;
    }
    if (t == _i8.User) {
      return _i8.User.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Example?>()) {
      return (data != null ? _i2.Example.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.Game?>()) {
      return (data != null ? _i3.Game.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.Guess?>()) {
      return (data != null ? _i4.Guess.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.GuessResult?>()) {
      return (data != null ? _i5.GuessResult.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.GuessResultTypes?>()) {
      return (data != null ? _i6.GuessResultTypes.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Message?>()) {
      return (data != null ? _i7.Message.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.User?>()) {
      return (data != null ? _i8.User.fromJson(data, this) : null) as T;
    }
    if (t == List<_i9.Guess>) {
      return (data as List).map((e) => deserialize<_i9.Guess>(e)).toList()
          as dynamic;
    }
    if (t == List<_i9.Game>) {
      return (data as List).map((e) => deserialize<_i9.Game>(e)).toList()
          as dynamic;
    }
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    String? className;
    className = _i10.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    if (data is _i2.Example) {
      return 'Example';
    }
    if (data is _i3.Game) {
      return 'Game';
    }
    if (data is _i4.Guess) {
      return 'Guess';
    }
    if (data is _i5.GuessResult) {
      return 'GuessResult';
    }
    if (data is _i6.GuessResultTypes) {
      return 'GuessResultTypes';
    }
    if (data is _i7.Message) {
      return 'Message';
    }
    if (data is _i8.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'].startsWith('serverpod_auth.')) {
      data['className'] = data['className'].substring(15);
      return _i10.Protocol().deserializeByClassName(data);
    }
    if (data['className'] == 'Example') {
      return deserialize<_i2.Example>(data['data']);
    }
    if (data['className'] == 'Game') {
      return deserialize<_i3.Game>(data['data']);
    }
    if (data['className'] == 'Guess') {
      return deserialize<_i4.Guess>(data['data']);
    }
    if (data['className'] == 'GuessResult') {
      return deserialize<_i5.GuessResult>(data['data']);
    }
    if (data['className'] == 'GuessResultTypes') {
      return deserialize<_i6.GuessResultTypes>(data['data']);
    }
    if (data['className'] == 'Message') {
      return deserialize<_i7.Message>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i8.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
