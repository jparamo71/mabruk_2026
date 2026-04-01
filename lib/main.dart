import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/services/shared_preferences_service.dart';
import 'package:mabruk_2026/utils/elements_size.dart';
import 'package:mabruk_2026/utils/globals.dart';
import 'package:mabruk_2026/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:mabruk_2026/widgets/main_menu_button.dart';

String? clientId =
    "156324557995-bnik93375mq5tg6q9lkk9hioriku9m80.apps.googleusercontent.com";
String? serverClientId =
    "156324557995-esj5sb7vldmr5blvgojrnsvq9hk67k73.apps.googleusercontent.com";
const List<String> scopes = <String>[
  'email' /*,
  'https://www.googleapis.com/auth/contacts.readonly',*/,
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Future.delayed(const Duration(seconds: 3));

  runApp(
    ChangeNotifierProvider(
      create: (_) => MabrukProvider(),
      child: MaterialApp(
        home: MyLogin(),
        title: 'MABRUK 2026',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLogin> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  final String _contactText = '';
  String _errorMessage = '';
  final String _serverAuthCode = '';

  @override
  void initState() {
    super.initState();
    _signIn();
  }

  /// If user is logged then skip the google authentication
  Future<bool> isLogged() async {
    await loadConfiguration();
    return userName != "";
  }

  void _signIn() async {
    if (await isLogged() == false) {
      final GoogleSignIn signIn = GoogleSignIn.instance;
      unawaited(
        signIn
            .initialize(clientId: clientId, serverClientId: serverClientId)
            .then((_) {
          signIn.authenticationEvents
              .listen(_handleAuthenticationEvent)
              .onError(_handleAuthenticationError);

          signIn.attemptLightweightAuthentication();
        }),
      );
    } else {
      print("No fue necesario autenticarse");
    }
  }

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes(scopes);

    setState(() {
      _currentUser = user;
      _isAuthorized = authorization != null;
      _errorMessage = '';
      userName = user?.email ?? "";
    });

    if (user != null && authorization != null) {
      //unawaited(_handleGetContact(user));
      await saveUserConfig(user.email, urlBase);
      print("Guarde la configuracion ${user.email} en ${urlBase}");
    }
  }

  Future<void> _handleAuthenticationError(Object e) async {
    setState(() {
      _currentUser = null;
      _isAuthorized = false;
      _errorMessage = e is GoogleSignInException
          ? _errorMessageFromSignInException(e)
          : 'Unknown error: $e';
    });
  }

  Future<void> _handleSignOut() async {
    await GoogleSignIn.instance.disconnect();
  }

  Widget _buildBody(BuildContext context) {
    //final GoogleSignInAccount? user = _currentUser;

    //print(userName);
    return (userName != "")
        ? _buildAuthenticatedWidgets()
        : _buildUnauthenticatedWidgets();
  }

  List<Widget> menuButtons() {
    return [
      MainMenuButton(
        text: 'PEDIDOS',
        icon: Icons.tty_sharp,
        onNavigate: () {
          Navigator.of(context).pushNamed("/documents");
        },
      ),
      MainMenuButton(
        text: 'COTIZACIONES',
        icon: Icons.app_registration_sharp,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/quotes");
        },
      ),
      MainMenuButton(
        text: 'PRODUCTOS',
        icon: Icons.archive,
        onNavigate: () {
          Navigator.of(context).pushNamed('/products');
        },
      ),
      MainMenuButton(
        text: 'INVENTARIOS',
        icon: Icons.inventory,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/tracking-inventories");
        },
      ),
      MainMenuButton(
        text: 'IMPORTACIONES',
        icon: Icons.edit_document,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/imports");
        },
      ),
      MainMenuButton(
        text: 'CÓDIGO DE BARRA',
        icon: Icons.qr_code,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/update-code");
        },
      ),
      MainMenuButton(
        text: 'CÓDIGO UPC',
        icon: Icons.qr_code_scanner,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/update-upc");
        },
      ),
      MainMenuButton(
        text: 'CONFIGURACIÓN',
        icon: Icons.settings,
        leftButton: false,
        onNavigate: allowUploadImages
            ? () {
          //Navigator.of(context)
          //    .pushNamed("/photo", arguments: 1629);
        }
            : () => null,
      ),
    ];
  }

  Widget _buildAuthenticatedWidgets() {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 60.0),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: menuButtons(),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: ElementsSize.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Image.asset('assets/infosercom_little.png'),
                    iconSize: 50,
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationIcon: Image.asset(
                          'assets/infosercom_little.png',
                        ),
                        applicationName: 'Mabruk Ventas',
                        applicationVersion: '2.2.0',
                        applicationLegalese: '\u{a9} Enero, 2026 INFOSERCOM',
                      );
                    },
                  ),
                  Text(
                    userName,
                    style: TextStyle(fontSize: 14, color: Color(0xFF353535)),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {}, //async => _signOut(),
                    child: const Text('Salir'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    /*return <Widget>[
      ListTile(
        leading: GoogleUserCircleAvatar(identity: user),
        title: Text(user.displayName ?? ''),
        subtitle: Text(user.email),
      ),
      const Text('Signed in successfully.'),
      if (_isAuthorized) ...<Widget>[
        if (_contactText.isNotEmpty) Text(_contactText),
        ElevatedButton(
          child: const Text('REFRESH'),
          onPressed: () => _handleGetContact(user),
        ),
        if (_serverAuthCode.isEmpty)
          ElevatedButton(
            child: const Text('REQUEST SERVER CODE'),
            onPressed: () => _handleGetAuthCode(user),
          )
        else
          Text('Server auth code:\n$_serverAuthCode'),
      ] else ...<Widget>[
        const Text('Authorization needed to read your contacts.'),
        ElevatedButton(
          onPressed: () => _handleAuthorizeScopes(user),
          child: const Text('REQUEST PERMISSIONS'),
        ),
      ],
      ElevatedButton(onPressed: _handleSignOut, child: const Text('SIGN OUT')),
    ];*/
  }

  Widget _buildUnauthenticatedWidgets() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          width: double.infinity,
          color: Colors.white,
          child: Image.asset('assets/mabruk.png', alignment: Alignment.center),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isAuthorized
                    ? _currentUser!.email
                    : "Autenticación de usuario requerida",
              ),
              userName != ''
                  ? TextButton(
                onPressed: () async => _handleSignOut(),
                child: const Text('Finalizar sesión'),
              )
                  : TextButton(
                onPressed: () async => _signIn(),
                child: const Text('Iniciar sesión'),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 180,
            width: ElementsSize.screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/mabruk_30.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Text(selectedConnection),
          ),
        ),
      ],
    );
  }

  Future<void> _connectionConfig(BuildContext context) async {
    final TextEditingController _controller = TextEditingController();

    _controller.text = urlBase;
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Servidor'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Datos del servidor"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Returns null
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(
                context,
                _controller.text,
              ), // Returns the string
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      urlBase = result;
      print("Cambio de servidor a: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _connectionConfig(context);
        },
        backgroundColor: const Color(0xcc567860),
        child: Icon(Icons.network_wifi, color: Colors.white),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(context),
      ),
    );
  }

  String _errorMessageFromSignInException(GoogleSignInException e) {
    return switch (e.code) {
      GoogleSignInExceptionCode.canceled => 'Sign in canceled',
      _ => 'GoogleSignInException ${e.code}: ${e.description}',
    };
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


/*
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final Map<String, String>? headers = await user.authorizationClient
        .authorizationHeaders(scopes);
    if (headers == null) {
      setState(() {
        _contactText = '';
        _errorMessage = 'Failed to construct authorization headers.';
      });
      return;
    }
    final http.Response response = await http.get(
      Uri.parse(
        'https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names',
      ),
      headers: headers,
    );
    if (response.statusCode != 200) {
      if (response.statusCode == 401 || response.statusCode == 403) {
        setState(() {
          _isAuthorized = false;
          _errorMessage =
              'People API gave a ${response.statusCode} response. '
              'Please re-authorize access.';
        });
      } else {
        print('People API ${response.statusCode} response: ${response.body}');
        setState(() {
          _contactText =
              'People API gave a ${response.statusCode} '
              'response. Check logs for details.';
        });
      }
      return;
    }
    final data = json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final connections = data['connections'] as List<dynamic>?;
    final contact =
        connections?.firstWhere(
              (dynamic contact) =>
                  (contact as Map<Object?, dynamic>)['names'] != null,
              orElse: () => null,
            )
            as Map<String, dynamic>?;
    if (contact != null) {
      final names = contact['names'] as List<dynamic>;
      final name =
          names.firstWhere(
                (dynamic name) =>
                    (name as Map<Object?, dynamic>)['displayName'] != null,
                orElse: () => null,
              )
              as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleAuthorizeScopes(GoogleSignInAccount user) async {
    try {
      final GoogleSignInClientAuthorization authorization = await user
          .authorizationClient
          .authorizeScopes(scopes);

      authorization;

      setState(() {
        _isAuthorized = true;
        _errorMessage = '';
      });
      unawaited(_handleGetContact(_currentUser!));
    } on GoogleSignInException catch (e) {
      _errorMessage = _errorMessageFromSignInException(e);
    }
  }

  Future<void> _handleGetAuthCode(GoogleSignInAccount user) async {
    try {
      final GoogleSignInServerAuthorization? serverAuth = await user
          .authorizationClient
          .authorizeServer(scopes);

      setState(() {
        _serverAuthCode = serverAuth == null ? '' : serverAuth.serverAuthCode;
      });
    } on GoogleSignInException catch (e) {
      _errorMessage = _errorMessageFromSignInException(e);
    }
  }
*/
