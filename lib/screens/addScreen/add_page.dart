import 'package:flutter/material.dart';
import 'package:todo_app/screens/services/firestore.dart';

class AddPageList extends StatefulWidget {
  const AddPageList({Key? key}) : super(key: key);

  @override
  State<AddPageList> createState() => _AddPageListState();
}

class _AddPageListState extends State<AddPageList> {
  final FirestoreServices firestoreServices = FirestoreServices();
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Todo")),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: discriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                String title = titleController.text;
                String description = discriptionController.text;
                if (title.isEmpty && description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Center(child: Text('Add Title and Discription')),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12.0))),
                        backgroundColor: Colors.red),
                  );
                } else if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(
                          child: Text('Description Added Successfully ')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12.0)),
                      ),
                      backgroundColor: Color.fromARGB(255, 27, 252, 184),
                    ),
                  );
                  firestoreServices.addNotes(title, description);
                  titleController.clear();
                  discriptionController.clear();
                } else if (description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text('Title Added Successfully')),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12.0))),
                      backgroundColor: Color.fromARGB(255, 27, 252, 184),
                    ),
                  );
                  firestoreServices.addNotes(title, description);
                  titleController.clear();
                  discriptionController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Center(child: Text('Task Submitted Successfully')),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12.0))),
                      backgroundColor: Color.fromARGB(255, 27, 252, 184),
                    ),
                  );

                  firestoreServices.addNotes(title, description);
                  titleController.clear();
                  discriptionController.clear();
                }
              });
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
