import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewWidget extends StatefulWidget {
  String uid;
  OverviewWidget({this.uid});

  @override
  _OverviewWidgetState createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  @override
  Widget build(BuildContext context) {
    final groceryItems = Provider.of<List<GroceryItem>>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        if(groceryItems[index].isSelected) {
          return ListTile(
            title: Text(groceryItems[index].name),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}