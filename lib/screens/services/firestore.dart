import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
// get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection("notes");

// CREATE:add a new note

  Future<void> addNotes(String title, String discription) {
    return notes.add({
      'Title': title,
      'Discription': discription,
      "Timestamp": Timestamp.now()
    });
  }

// READ:get notes from database

  Stream<QuerySnapshot> getNoteStream() {
    final noteStream = notes.orderBy("Timestamp").snapshots();

    return noteStream;
  }

//UPDATE:update notes given a doc id
  Future<void> updateNote(
      String docID, String newTitle, String newDescription) {
    return notes.doc(docID).update({
      'Title': newTitle,
      'Discription': newDescription,
      "Timestamp": Timestamp.now(),
    });
  }

//DELETE: delete notes given a doc id

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
