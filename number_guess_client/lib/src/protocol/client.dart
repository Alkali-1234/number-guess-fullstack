/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:number_guess_client/src/protocol/user.dart' as _i3;
import 'package:serverpod_auth_client/module.dart' as _i4;
import 'protocol.dart' as _i5;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// Handles user statistics, uses streams to keep the user updated
/// {@category Endpoint}
class EndpointGetUserStats extends _i1.EndpointRef {
  EndpointGetUserStats(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'getUserStats';

  _i2.Future<_i3.User> getUserStats() => caller.callServerEndpoint<_i3.User>(
        'getUserStats',
        'getUserStats',
        {},
      );
}

/// {@category Endpoint}
class EndpointRandomNumber extends _i1.EndpointRef {
  EndpointRandomNumber(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'randomNumber';

  _i2.Future<int> generateRandomNumber() => caller.callServerEndpoint<int>(
        'randomNumber',
        'generateRandomNumber',
        {},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i4.Caller(client);
  }

  late final _i4.Caller auth;
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i5.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    example = EndpointExample(this);
    getUserStats = EndpointGetUserStats(this);
    randomNumber = EndpointRandomNumber(this);
    modules = _Modules(this);
  }

  late final EndpointExample example;

  late final EndpointGetUserStats getUserStats;

  late final EndpointRandomNumber randomNumber;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'getUserStats': getUserStats,
        'randomNumber': randomNumber,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
