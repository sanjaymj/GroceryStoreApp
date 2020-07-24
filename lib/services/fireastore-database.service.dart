import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatabaseService {
  String uid;
  FirestoreDatabaseService({this.uid});
  List<GroceryItem> initial= [];

  Future updateUserData(String sugars, String name, int strength) async {
    return await Firestore.instance.collection(uid).document('item1').setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  List<GroceryItem> _groceryItemsFromSnapshot(QuerySnapshot snapshots) {
    return snapshots.documents.map((doc){
      return GroceryItem(name: doc.data['name'] ?? '');
    }).toList();
  }

  List<GroceryItem> _groceryItemsFromSnapshot1(QuerySnapshot snapshots) {
    final List<GroceryItem> items= [];
    snapshots.documents.forEach((doc){
      
    items.add(GroceryItem(
      name: doc['name'] ?? '',
      isSelected: doc['isSelected'] ?? false,
      category: doc['category'] ?? ''));
    });
    items.sort((a,b)=> a.name.compareTo(b.name));
    print(items);
    return items;
  }

  List<String> _groceryItemCategories(QuerySnapshot snapshots) {
    final List<String> categories= [];
    snapshots.documents.forEach((doc){
      doc.data['items'].forEach((item){
        if (!categories.contains(item['category'])) {
          categories.add(item['category']);
        }
      });
    });
    return categories;
  }

  _selectAll() {
    print(initial);
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          print(value.documentID);
          Firestore.instance.collection(uid).document(value.documentID).updateData({'name': value.data['name'], 'isSelected': true, 'category': value.data['category']});

        })
      }});
  }

  _deSelectAll() {
    print(initial);
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          print(value.documentID);
          Firestore.instance.collection(uid).document(value.documentID).updateData({'name': value.data['name'], 'isSelected': false, 'category': value.data['category']});

        })
      }});
  }

  Stream<List<GroceryItem>> get brews {
    print(uid);
    return Firestore.instance.collection(uid).snapshots().map(_groceryItemsFromSnapshot1);
  }

  Stream<List<String>> get categories {
    return Firestore.instance.collection(uid).snapshots().map(_groceryItemCategories);
  }

  update(GroceryItem item) {
    print(uid);
    print('in update');
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          print(value.documentID);
          if (value.data['name'] == item.name) {
              print('herte!!!!');
              Firestore.instance.collection(uid).document(value.documentID).updateData({'name': value.data['name'], 'isSelected': item.isSelected, 'category': value.data['category']});
              return;
          }
        })
      }});

    //itemsCollection.document('item1').updateData({'name': item.name, 'isSelected': item.isSelected, 'category': item.category});
    /* itemsCollection.document('8BcSh0K7GUQgnaf7zBKZPWpb1zu1').updateData({'items': FieldValue.arrayRemove([{'name': item.name, 'isSelected': !item.isSelected, 'category': item.category}])});
    itemsCollection.document('8BcSh0K7GUQgnaf7zBKZPWpb1zu1').updateData({'items': FieldValue.arrayUnion([{'name': item.name, 'isSelected': item.isSelected, 'category': item.category}])}); */
  }

  selectAll() {
    print('in select');
    print(initial);
    _selectAll();
    /* disable = true;
    itemsCollection.snapshots().forEach(_selectAll).then((_val)=> {
      //disable = false
    }); */
  }

  deSelectAll() {
    print('in select');
    print(initial);
    _deSelectAll();
    /* disable = true;
    itemsCollection.snapshots().forEach(_selectAll).then((_val)=> {
      //disable = false
    }); */
  }

  addNewItem(String itemName, String itemCategory) {
    var newItem = true;

    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          if (value.data['name'] == itemName && value.data['category'] == itemCategory) {
              newItem = false;
              return;
          }
        })
      }});
    
    if (newItem) {
      Firestore.instance.collection(uid).document(Uuid().v1()).setData({'name': itemName, 'isSelected': true, 'category': itemCategory});
    }
  }
} 