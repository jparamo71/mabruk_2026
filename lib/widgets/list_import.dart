import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/import_model.dart';

class ListImports extends StatelessWidget {
  final List<ImportModel> imports;
  const ListImports({super.key, required this.imports});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imports.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    /*Import.getInfo(imports[index].id).then((imp) {
                      Navigator.of(
                        context,
                      ).pushNamed("/viewimport", arguments: imp);
                    });*/
                  },
                ),
              ),
              Expanded(flex: 1, child: Text(imports[index].documentTypeId)),
              Expanded(flex: 1, child: Text(imports[index].documentNumber)),
              Expanded(flex: 1, child: Text(imports[index].documentDateStr)),
              Expanded(
                flex: 1,
                child: Text(imports[index].totalValue.toString()),
              ),
              Expanded(flex: 1, child: Text(imports[index].status)),
            ],
          ),
        );
      },
    );
  }
}
