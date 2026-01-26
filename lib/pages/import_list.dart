import 'package:flutter/material.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/list_import.dart';
import 'package:provider/provider.dart';

class ImportList extends StatefulWidget {
  const ImportList({super.key});

  @override
  State<ImportList> createState() => _ImportListState();
}

class _ImportListState extends State<ImportList> {
  @override
  void initState() {
    Provider.of<MabrukProvider>(context, listen: false).getImports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('IMPORTACIONES'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<MabrukProvider>(
                builder: (context, value, child) {
                  if (value.importsModel.isNotEmpty) {
                    return ListImports(
                      imports: context.watch<MabrukProvider>().importsModel,
                    );
                  }
                  return const Center(child: Text("xxxx"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
