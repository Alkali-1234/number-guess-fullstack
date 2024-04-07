/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/get_user_stats.dart' as _i3;
import '../endpoints/random_number_endpoint.dart' as _i4;
import 'package:serverpod_auth_server/module.dart' as _i5;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'example': _i2.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'getUserStats': _i3.GetUserStatsEndpoint()
        ..initialize(
          server,
          'getUserStats',
          null,
        ),
      'randomNumber': _i4.RandomNumberEndpoint()
        ..initialize(
          server,
          'randomNumber',
          null,
        ),
    };
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i2.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['getUserStats'] = _i1.EndpointConnector(
      name: 'getUserStats',
      endpoint: endpoints['getUserStats']!,
      methodConnectors: {
        'getUserStats': _i1.MethodConnector(
          name: 'getUserStats',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['getUserStats'] as _i3.GetUserStatsEndpoint)
                  .getUserStats(session),
        )
      },
    );
    connectors['randomNumber'] = _i1.EndpointConnector(
      name: 'randomNumber',
      endpoint: endpoints['randomNumber']!,
      methodConnectors: {
        'generateRandomNumber': _i1.MethodConnector(
          name: 'generateRandomNumber',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['randomNumber'] as _i4.RandomNumberEndpoint)
                  .generateRandomNumber(session),
        )
      },
    );
    modules['serverpod_auth'] = _i5.Endpoints()..initializeEndpoints(server);
  }
}
