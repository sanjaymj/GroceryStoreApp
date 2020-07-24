import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:dinci_samaan/services/fireastore-database.service.dart';
import 'package:dinci_samaan/services/firebase-auth.service.dart';
import 'package:dinci_samaan/views/home/floating-button-wrapper.dart';
import 'package:dinci_samaan/views/home/overview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

import 'item-category-list.dart';
import 'items-list.dart';


class Home extends StatelessWidget {
  String uid;

  Home({this.uid});
  FirebaseAuthService _auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<GroceryItem>>.value(
          value: FirestoreDatabaseService(uid: this.uid).brews,
          child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('My app'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                }, 
                icon: Icon(Icons.person), 
                label: Text('label'))
            ],
          ),
          body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Select Items'),
                  Tab(text: 'Overview'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ItemCategoryList(uid: this.uid),
                OverviewWidget(uid: this.uid),
              ],
            ),
          ),
      )
        ),
        
    );
  }
}