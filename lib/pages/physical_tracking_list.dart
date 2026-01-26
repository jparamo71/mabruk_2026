import 'package:flutter/material.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/palette_theme.dart';
import 'package:mabruk_2026/widgets/list_tracking_inventories.dart';
import 'package:provider/provider.dart';

class PhysicalTrackingList extends StatefulWidget {
  const PhysicalTrackingList({super.key});

  @override
  State<PhysicalTrackingList> createState() => _PhysicalTrackingListState();
}

class _PhysicalTrackingListState extends State<PhysicalTrackingList> {
  @override
  void initState() {
    Provider.of<MabrukProvider>(
      context,
      listen: false,
    ).getTrackingInventories(1, 0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('TOMA FÍSICA'),
        centerTitle: true,
      ),
      body: Consumer<MabrukProvider>(
        builder: (context, value, child) {
          if (value.inventoriesModel.isNotEmpty) {
            return ListTrackingInventories(
              physicalTrackings: context
                  .watch<MabrukProvider>()
                  .inventoriesModel,
            );
          }
          return const Center(child: Text("xxxx"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_showDocumentAndWaitAnswer(context);
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
