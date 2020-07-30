import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';
import 'package:dinci_samaan/views/home/user-alert-dialog.dart';
import 'package:flutter/material.dart';

class GroceryItemTile extends StatelessWidget {

  deleteItem() {
    FirestoreDatabaseService(uid: uid).deleteItem(item, this.uid);
  }
  String uid = '';
  final GroceryItem item;
  GroceryItemTile({this.uid, this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
          return UserAlertDialog(alertText: 'Are you sure you want to delete the item', callback: this.deleteItem);
        });
      },
      child: SwitchListTile(
        title: Text(item.name),
        value: item.isSelected,
        onChanged: (bool value) {
          item.isSelected = value;
          FirestoreDatabaseService(uid:this.uid).update(item);
        },
      ),
    );
  }
}