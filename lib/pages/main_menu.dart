import 'package:flutter/material.dart';
import 'package:mabruk_2026/utils/elements_size.dart';
import 'package:mabruk_2026/utils/globals.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/main_menu_button.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackGround,
      //drawer: MabrukDrawer(),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(28.0),
          width: double.maxFinite,
          height: 120,
          color: Colors.white,
          child: Image.asset('assets/mabruk.png', alignment: Alignment.center),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GridView(
              padding: EdgeInsets.all(20.0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 275,
                childAspectRatio: 1,
                mainAxisExtent: 250.0,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
              children: menuButtons(),
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
      ),
    );
  }

  List<Widget> menuButtons() {
    double widthButton =
        (MediaQuery.of(context).size.width - (ElementsSize.width30 * 2)) / 2;
    return [
      MainMenuButton(
        width: widthButton,
        height: widthButton,
        text: 'PEDIDOS',
        icon: Icons.tty_sharp,
        onNavigate: () {
          Navigator.of(context).pushNamed("/documents");
        },
      ),
      MainMenuButton(
        width: widthButton,
        height: widthButton,
        text: 'COTIZACIONES',
        icon: Icons.app_registration_sharp,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/quotes");
        },
      ),
      MainMenuButton(
        width: widthButton,
        height: widthButton,
        text: 'PRODUCTOS',
        icon: Icons.archive,
        onNavigate: () {
          Navigator.of(context).pushNamed('/products');
        },
      ),
      MainMenuButton(
        width: 0,
        height: 0,
        text: 'INVENTARIOS',
        icon: Icons.inventory,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/tracking-inventories");
        },
      ),
      MainMenuButton(
        width: 0,
        height: 0,
        text: 'IMPORTACIONES',
        icon: Icons.edit_document,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/imports");
        },
      ),
      MainMenuButton(
        width: 0,
        height: 0,
        text: 'CÓDIGO DE BARRA',
        icon: Icons.qr_code,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/update-code");
        },
      ),
      MainMenuButton(
        width: 0,
        height: 0,
        text: 'CÓDIGO UPC',
        icon: Icons.qr_code_scanner,
        leftButton: false,
        onNavigate: () {
          Navigator.of(context).pushNamed("/update-upc");
        },
      ),
      MainMenuButton(
        width: widthButton,
        height: widthButton,
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
}
