import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:dinci_samaan/views/home/floating-button-wrapper.dart';
import 'package:dinci_samaan/views/home/grocery-item-tile.dart';
import 'package:dinci_samaan/views/home/items-list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';

class ItemCategoryList extends StatefulWidget {

  String uid = '';
  ItemCategoryList({this.uid});
  @override
  _ItemCategoryListState createState() => _ItemCategoryListState();
}

class _ItemCategoryListState extends State<ItemCategoryList> {
  List<String> _groceryItemCategories(List<GroceryItem> items) {
    final List<String> categories= [];
    items.forEach((item){
      if (!categories.contains(item.category)) {
        categories.add(item.category);
      }
    });
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final groceryItems = Provider.of<List<GroceryItem>>(context);
    final categories = _groceryItemCategories(groceryItems);
    return new Scaffold(
          body: new ListView(
          children: [new ExpansionPanelList.radio(
          initialOpenPanelValue: 1,
          children:  categories.map<ExpansionPanelRadio>((String item) {
            return ExpansionPanelRadio(
                value: item,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item),
                  );
                }, body: ItemsList(uid: widget.uid, currentCategory: item),
                
                );
              }).toList(),
            ),
          ]),
          floatingActionButton: FloatingButtonWrapper(uid: widget.uid)
    );
  }
}