import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('Users')
        .where('code',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}