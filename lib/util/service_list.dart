import 'package:admin_salon/util/service_container.dart';
import 'package:admin_salon/views/my%20salon/edit_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatelessWidget {
  final String category;
  const ServiceList(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('services').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        final documents = snapshot.data!.docs;
        final Data = documents
            .where((doc) => doc['category'].contains(category))
            .toList();

        if (Data.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: Data.length,
          itemBuilder: (context, index) {
            final doc = Data[index];

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(width: 0.7),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceContainer(doc['name'], doc['gender'],
                          doc['imageUrl'], doc['price']),
                      Container(
                          height: 40,
                          //width: 70,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(width: 0.7),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(4, 4))
                              ]),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _editItem(context, doc);
                                },
                                child: Container(
                                  //height: 70,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      12,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                                    border: Border.all(width: 0.7),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _deleteItem(doc);
                                },
                                child: Container(
                                  //height: 68.6,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      12,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(width: 0.7),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.delete_outline,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        );
      },
    );
  }

  void _editItem(BuildContext context, DocumentSnapshot doc) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditServicePage(documentId: doc.id)));
    print('Edit button pressed for ${doc['name']}');
  }

  void _deleteItem(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('services').doc(doc.id).delete();
    print('Deleted item ${doc['name']}');
  }
}
