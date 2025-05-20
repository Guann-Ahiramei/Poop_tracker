import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../services/firebase_goal_service.dart';

class GoalProvider with ChangeNotifier {
  final FirebaseGoalService _service = FirebaseGoalService();
  List<Goal> _goals = [];

  List<Goal> get goals => _goals;

  Future<void> loadGoals() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('goals')
        .orderBy('order') // ✅ 关键排序字段
        .get();

    _goals = snapshot.docs.map((doc) => Goal.fromMap(doc.id, doc.data())).toList();
    notifyListeners();
  }

  Future<void> addGoal(Goal goal) async {
    await _service.addGoal(goal);
    await loadGoals();
  }

  Future<void> completeGoal(String id, DateTime end, String note) async {
    await _service.completeGoal(id, end, note);
    await loadGoals();
  }

  Future<void> deleteGoal(String id) async {
    await _service.deleteGoal(id);
    await loadGoals();
  }

  Future<void> editGoal(String id, String title) async {
    await _service.editGoalTitle(id, title);
    await loadGoals();
  }
  void reorderGoals(int oldIndex, int newIndex) {
    final moved = goals.removeAt(oldIndex);
    goals.insert(newIndex, moved);
    notifyListeners();
  }

  Future<void> saveReorderedGoals() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final batch = FirebaseFirestore.instance.batch();

    for (int i = 0; i < goals.length; i++) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('goals')
          .doc(goals[i].id);
      batch.update(docRef, {'order': i});
    }

    await batch.commit();
  }




}
