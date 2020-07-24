import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:dinci_samaan/views/home/grocery-item-tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';

class OverviewWidget extends StatefulWidget {
  String uid;
  OverviewWidget({this.uid});

  @override
  _OverviewWidgetState createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<GroceryItem>>(context);
    print('#1#1#1#1#1');
    print(brews);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: brews.length,
      itemBuilder: (context, index) {
        print(brews[index].category);
        if(brews[index].isSelected) {
          return ListTile(
            title: Text(brews[index].name),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}