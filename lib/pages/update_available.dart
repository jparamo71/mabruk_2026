import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateAvailable extends StatefulWidget {
  const UpdateAvailable({super.key});

  @override
  State<UpdateAvailable> createState() => _UpdateAvailableState();
}

class _UpdateAvailableState extends State<UpdateAvailable> {
  final txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ingrese conteo o existencia'),
            SizedBox(height: 8.0),
            SizedBox(
              //height: 32, 
              width: 200,
              child: TextField(
                controller: txtController,
                textAlign: TextAlign.end,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                       ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.0',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, txtController.text);
                  },
                  child: Text('Aceptar'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}