import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_list/models/list.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Id do usuário logado
  String? get _userId => _auth.currentUser?.uid;

  CollectionReference<ItemsList> get _listRef {
    final userId = _userId;
    if (userId == null) throw Exception("User not logged in");
    
    return _db
        .collection('users')
        .doc(userId)
        .collection('lists')
        .withConverter<ItemsList>(
          fromFirestore: (snapshot, _) => ItemsList.fromJson(
            snapshot.data()!,
            snapshot.id,
          ),
          toFirestore: (list, _) => list.toJson(),
        );
  }

  // Obter stream de listas do usuário
  Stream<List<ItemsList>> getLists() {
    return _listRef
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Adicionar nova lista
  Future<void> addList(String name) async {
    final newList = ItemsList(name: name);
    await _listRef.add(newList);
  }

  // Atualiza lista
  Future<void> updateList(ItemsList list) async {
    final listId = list.id;
    if (listId == null) return;
    await _listRef.doc(listId).set(list);
  }

  // Excluir uma lista
  Future<void> deleteList(String listId) async {
    await _listRef.doc(listId).delete();
  }
}
