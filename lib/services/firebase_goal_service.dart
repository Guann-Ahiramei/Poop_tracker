//和 Firebase 交互
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/goal.dart';

class FirebaseGoalService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addGoal(Goal goal) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    final docRef = await _firestore
        .collection('users')
        .doc(uid)
        .collection('goals')
        .add(goal.toMap());

    return docRef.id;
  }

  Future<List<Goal>> fetchGoals() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('goals')
        .orderBy('startTime', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Goal.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> completeGoal(String goalId, DateTime endTime, String moodNote) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('goals')
        .doc(goalId)
        .update({
      'endTime': endTime.toIso8601String(),
      'moodNote': moodNote,
      'completed': true,
    });
  }

  Future<void> deleteGoal(String goalId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('goals')
        .doc(goalId)
        .delete();
  }

  Future<void> editGoalTitle(String goalId, String newTitle) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('goals')
        .doc(goalId)
        .update({
      'title': newTitle,
    });
  }
}
