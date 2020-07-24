import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewItemDialog extends StatefulWidget {
  String uid;
  NewItemDialog({this.uid});
  @override 
  State<StatefulWidget> createState() => _NewItemDialogState();
}


class _NewItemDialogState extends State<NewItemDialog> {
  String itemName = '';
  String itemCategory = '';
  var uuid = Uuid();

 @override 
  Widget build(BuildContext context) {
    return AlertDialog(
            title: Text('Add new Item to shop!'),
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Item Name",
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        ),
                          onChanged: (String value) {
                            this.itemName = value;
                          }
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Enter Item Category",
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        ),
                          onChanged: (String value) {
                            this.itemCategory = value;
                          }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Add Item"),
                          onPressed: () => {
                            
                            if (this.itemName.isNotEmpty) {
                              FirestoreDatabaseService(uid:widget.uid).addNewItem(itemName, itemCategory),
                            },
                            Navigator.pop(context)
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
