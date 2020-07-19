import 'package:dinci_samaan/services/fireastore-database.service.dart';
import 'package:flutter/material.dart';

class FloatingButtonWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left:31),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: () {
              
            },
            child: Icon(Icons.delete),),
        ),),

        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              
          },
          child: Icon(Icons.add),),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              print('heree');
              FirestoreDatabaseService().selectAll();
            },
          child: Icon(Icons.select_all),),
        ),
      ],
    );
  }
}