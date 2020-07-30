import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatabaseService {
  String uid;
  FirestoreDatabaseService({this.uid});
  List<GroceryItem> initial= [];

  List<GroceryItem> _groceryItemsFromSnapshot(QuerySnapshot snapshots) {
    final List<GroceryItem> items= [];
    snapshots.documents?.forEach((doc){
      
    items.add(GroceryItem(
      name: doc['name'] ?? '',
      isSelected: doc['isSelected'] ?? false,
      category: doc['category'] ?? ''));
    });
    items.sort((a,b)=> a.name.compareTo(b.name));
    return items;
  }

  List<String> _groceryItemCategories(QuerySnapshot snapshots) {
    final List<String> categories= [];
    snapshots.documents?.forEach((doc){
        if (!categories.contains(doc['category'])) {
          categories.add(doc['category']);
        }
    });
    return categories;
  }

  Stream<List<GroceryItem>> get groceryItems {
    return Firestore.instance.collection(uid).snapshots().map(_groceryItemsFromSnapshot);
  }

  Stream<List<String>> get categories {
    return Firestore.instance.collection(uid).snapshots().map(_groceryItemCategories);
  }

  update(GroceryItem item) {
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          if (value.data['name'] == item.name) {
              Firestore.instance.collection(uid).document(value.documentID).updateData({'name': value.data['name'], 'isSelected': item.isSelected, 'category': value.data['category']});
              return;
          }
        })
      }});

  }

  selectAll() {
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          Firestore.instance.collection(uid).document(value.documentID).updateData({'name': value.data['name'], 'isSelected': true, 'category': value.data['category']});

        })
      }});
  }

  deSelectAll() {
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          Firestore.instance.collection(uid).document(value.documentID).updateData({'name': value.data['name'], 'isSelected': false, 'category': value.data['category']});
        })
      }});
  }

  addNewItem(String itemName, String itemCategory) {
    var newItem = true;

    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          if (value.data['name'] == itemName.toLowerCase() && value.data['category'] == itemCategory.toLowerCase()) {
              newItem = false;
              return;
          }
        })
      },
      if (newItem) {
      Firestore.instance.collection(uid).document(Uuid().v1()).setData({'name': itemName.toLowerCase(), 'isSelected': true, 'category': itemCategory.toLowerCase()})
    }
      });
  }

  deleteItem(GroceryItem item, String uid) {
    Firestore.instance.collection(uid).getDocuments().then((ds) => {
      if (ds != null) {
        ds.documents.forEach((value){
          if (value.data['name'] == item.name.toLowerCase() && value.data['category'] == item.category.toLowerCase()) {
              Firestore.instance.collection(uid).document(value.documentID).delete();
              return;
          }
        })
      },
      });
  }
} 