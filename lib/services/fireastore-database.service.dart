import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinci_samaan/models/GroceryItems.dart';

class FirestoreDatabaseService {
  final CollectionReference itemsCollection = Firestore.instance.collection('items');
  final String uid;
  FirestoreDatabaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await itemsCollection.document(uid).setData({
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
    snapshots.documentChanges.forEach((changes)=>{
      print('here1111'),
      print(changes.document.data['items'])
    });
    print('again in get');
    snapshots.documents.forEach((doc){
      doc.data['items'].forEach((item){
        print('!!!!');
        print(item['category']);
        items.add(GroceryItem(
          name: item['name'] ?? '',
          isSelected: item['isSelected'] ?? false,
          category: item['category'] ?? ''));
      });
    });
    items.sort((a,b)=> a.name.compareTo(b.name));
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

  _selectAll(QuerySnapshot snapshots) {
    print('in selectAll');
    snapshots.documents.forEach((doc){
      doc.data['items'].forEach((item){
        itemsCollection.document('8BcSh0K7GUQgnaf7zBKZPWpb1zu1').updateData({'items': FieldValue.arrayRemove([{'name': item['name'], 'isSelected': item['isSelected'], 'category': item['category']}])});
        itemsCollection.document('8BcSh0K7GUQgnaf7zBKZPWpb1zu1').updateData({'items': FieldValue.arrayUnion([{'name': item['name'], 'isSelected': true, 'category': item['category']}])});
      });
    });
  }

  Stream<List<GroceryItem>> get brews {
    return itemsCollection.snapshots().map(_groceryItemsFromSnapshot1);
  }

  Stream<List<String>> get categories {
    return itemsCollection.snapshots().map(_groceryItemCategories);
  }

  update(GroceryItem item) {
    print(uid);
    print('in update');
    itemsCollection.document('8BcSh0K7GUQgnaf7zBKZPWpb1zu1').setData({'items': FieldValue.arrayRemove([{'name': item.name, 'isSelected': !item.isSelected, 'category': item.category}])});
    itemsCollection.document('8BcSh0K7GUQgnaf7zBKZPWpb1zu1').setData({'items': FieldValue.arrayUnion([{'name': item.name, 'isSelected': item.isSelected, 'category': item.category}])});
  }

  selectAll() {
    print('in select');
    //Firestore.instance.collection('city').document('Attractions').updateData({"data": FieldValue.arrayUnion(obj)});
  }
} 