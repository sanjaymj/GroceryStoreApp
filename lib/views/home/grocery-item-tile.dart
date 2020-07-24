import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';
import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {

  String uid = '';
  final GroceryItem item;
  GroceryItemTile({this.uid, this.item});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
          title: Text(item.name),
          value: item.isSelected,
          onChanged: (bool value) {
            item.isSelected = value;
            FirestoreDatabaseService(uid:this.uid).update(item);
          },
        );
  }
}