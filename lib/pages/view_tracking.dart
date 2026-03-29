import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/physical_tracking.dart';
import 'package:mabruk_2026/models/physical_tracking_detail_model.dart';
import 'package:mabruk_2026/pages/update_available.dart';
import 'package:mabruk_2026/providers/mabruk_provider.dart';
import 'package:mabruk_2026/utils/styles/big_text.dart';
import 'package:provider/provider.dart';

class ViewTracking extends StatefulWidget {
  final int id;
  const ViewTracking({super.key, required this.id});

  @override
  State<ViewTracking> createState() => _ViewTrackingState();
}

class _ViewTrackingState extends State<ViewTracking> {
  @override
  void initState() {
    final provider = Provider.of<MabrukProvider>(context, listen: false);
    provider.getImportInfo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MabrukProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          child: Consumer<MabrukProvider>(
            builder: (context, value, child) {
              if (value.selectedPhysicalTracking != null) {
                PhysicalTrackingModel physicalTracking =
                    value.selectedPhysicalTracking!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            BigText(physicalTracking.markName),
                            SizedBox(width: 8.0),
                            Text(physicalTracking.dateStart.toString()),
                            SizedBox(width: 8.0),
                            BigText(
                              physicalTracking.status,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(
                          //height: 32,
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Buscar producto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    // Details
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          border: TableBorder.all(),
                          columnWidths: const <int, TableColumnWidth>{
                            0: IntrinsicColumnWidth(),
                            1: FlexColumnWidth(),
                            2: FixedColumnWidth(124),
                            3: FixedColumnWidth(124),
                            4: FixedColumnWidth(40),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Código"),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Producto"),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Conteo físico"),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Sistema"),
                                ),
                                Text(""),
                              ],
                            ),
                            ...physicalTracking.details!
                                .map((e) => _buildTableRow(e, provider))
                                ,
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text("xxxx"));
            },
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    PhysicalTrackingDetailModel item,
    MabrukProvider provider,
  ) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(item.barcharCode),
        ),
        Container(
          height: 32,
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(item.productName),
        ),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            item.physicalQuantity.toString(),
            textAlign: TextAlign.right,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            item.systemAvailable.toString(),
            textAlign: TextAlign.right,
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          icon: Icon(Icons.info_outline_rounded),
          onPressed: () {
            _navigateAndDisplaySelection(context, item, provider);
          },
        ),
      ],
    );
  }


  Future<void> _navigateAndDisplaySelection(
    BuildContext context,
    PhysicalTrackingDetailModel item,
    MabrukProvider provider,
  ) async {    
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UpdateAvailable()),
    );

    item.physicalQuantity = double.parse(result.toString());
    item.difference = item.systemAvailable - item.physicalQuantity;

    if (!context.mounted) return;

    provider.updateTrackingProduct(item);
    
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
