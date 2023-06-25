import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static FirebaseServices? _instance;

  FirebaseServices._();

  static FirebaseServices get instance {
    _instance ??= FirebaseServices._();
    return _instance!;
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> updatedData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data()))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<List<T>> collectionFuture<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
    final List<T> result = snapshot.docs
        .map((snapshot) => builder(snapshot.data()))
        .where((value) => value != null)
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
  }) {
    final DocumentReference<Map<String, dynamic>> reference =
        FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()));
  }

  Future<T> documentFuture<T>({
    required String path,
    required T Function(Map<String, dynamic>? data) builder,
  }) async {
    final DocumentReference<Map<String, dynamic>> reference =
        FirebaseFirestore.instance.doc(path);
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await reference.get();
    return builder(snapshot.data());
  }
}
