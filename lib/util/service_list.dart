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
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No data available.'));
        }

        final documents = snapshot.data!.docs;
        final Data = documents
            .where((doc) => doc['category'].contains(category))
            .toList();

        if (Data.isEmpty) {
          return Center(child: Text('No data available.'));
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: Data.length,
          itemBuilder: (context, index) {
            final doc = Data[index];

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(width: 0.7),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(4, 4))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceContainer(doc['name'], doc['gender'],
                          doc['imageUrl'], doc['price']),
                      Container(
                          height: 140,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              border: Border.all(width: 0.7),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(4, 4))
                              ]),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _editItem(context, doc);
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                    ),
                                    border: Border.all(width: 0.7),
                                  ),
                                  child: Center(
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
                                  height: 68.6,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(width: 0.7),
                                  ),
                                  child: Center(
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
                SizedBox(
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
