import 'package:autocomplete_textfield/autocomplete_textfield.dart';
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
  bool categoryEntered = false;
  AutoCompleteTextField catField;
  GlobalKey<AutoCompleteTextFieldState<String>> cat = new GlobalKey(); 
  var uuid = Uuid();

 @override 
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: FirestoreDatabaseService(uid: widget.uid).categories,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
            return Text("Loading..");
          }
        return AlertDialog(
                title: Text('Add new Item'),
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
                                setState(() => {
                                  this.itemName = value
                                });
                                
                              }
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: catField = AutoCompleteTextField<String>(
                              decoration: InputDecoration(
                                labelText: "Enter Item Category",
                                enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                              ),
                              suggestions: snapshot.data,
                              key: cat,
                              clearOnSubmit: false,
                              itemSorter: (a,b){
                                return a.compareTo(b);
                              },
                              textChanged: (item){
                                setState(() {
                                  this.categoryEntered = item.isNotEmpty;
                                });
                              },
                              itemSubmitted: (item){
                                setState(() {
                                  this.catField.textField.controller.text = item;
                                });
                              },
                              itemFilter: (item, query){
                                return item.toLowerCase().startsWith(query.toLowerCase());
                              },
                              itemBuilder: (context, item){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(item,
                                    style: TextStyle(fontSize:20.0),),
                                    SizedBox(width: 30.0,), 
                                  ]
                                );
                              },
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Add Item"),
                              onPressed: this.itemName.isEmpty || !this.categoryEntered? null: () => {
                                if (this.itemName.isNotEmpty) {
                                  FirestoreDatabaseService(uid:widget.uid).addNewItem(itemName, catField.textField.controller.text),
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
    );
  }
}
