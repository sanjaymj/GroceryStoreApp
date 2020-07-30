import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:dinci_samaan/views/home/grocery-item-tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';

class ItemsList extends StatefulWidget {
  final String currentCategory;
  String uid;
  ItemsList({this.uid, this.currentCategory});

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    final groceryItems = Provider.of<List<GroceryItem>>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        if(groceryItems[index].category == widget.currentCategory) {
          return GroceryItemTile(uid: widget.uid, item: groceryItems[index]);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}