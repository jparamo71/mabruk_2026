import 'package:flutter/material.dart';
import 'package:mabruk_2026/models/physical_tracking.dart';

class ListTrackingInventories extends StatelessWidget {
  final List<PhysicalTrackingModel> physicalTrackings;
  const ListTrackingInventories({super.key, required this.physicalTrackings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: physicalTrackings.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.track_changes),
          title: Text(physicalTrackings[index].markName),
          subtitle: Text(physicalTrackings[index].dateStart.toString()),
          trailing: IconButton(
            onPressed: () {
              /*PhysicalTrackingModel.allFromJson(physicalTrackings[index].id).then((pt) {
                Navigator.of(context).pushNamed("/viewtracking", arguments: pt);
              });*/
            },
            icon: Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
