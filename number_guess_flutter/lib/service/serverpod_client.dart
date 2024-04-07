import 'package:number_guess_client/number_guess_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  //TODO : Change to the server ip address
  const ipAddress = 'localhost';

  /* Sets up a singleton client object that can be used to talk to the server from
   anywhere in our app. The client is generated from your server code.
   The client is set up to connect to a Serverpod running on a local server on
   the default port. You will need to modify this to connect to staging or
   production servers. */
  client = Client(
    'http://$ipAddress:8080/',
    //* Set up the authentication key manager, it uses the shared preferences to store the authentication key
    authenticationKeyManager: FlutterAuthenticationKeyManager(),

    //* Set up the connectivity monitor, which keeps track of the internet connectivity
  )..connectivityMonitor = FlutterConnectivityMonitor();

  //* The session manager, which keeps track of the signed-in state of the user
  sessionManager = SessionManager(caller: client.modules.auth);

  //* Finally, initialize the session manager
  await sessionManager.initialize();
}
