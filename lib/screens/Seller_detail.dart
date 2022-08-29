import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Get_Seller extends StatefulWidget {
  Get_Seller();

  @override
  State<Get_Seller> createState() => _Get_SellerState();
}

class _Get_SellerState extends State<Get_Seller> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sellers"),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('seller').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot curdoc = snapshot.data!.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.grey[300],
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Owner: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          curdoc['name'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Business: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          curdoc['busines-name'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Number: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          curdoc['number'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Status: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          curdoc['status'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  // FlutterSwitch(
                                  //   width: 55.0,
                                  //   height: 25.0,
                                  //   valueFontSize: 12.0,
                                  //   toggleSize: 18.0,
                                  //   value: status,
                                  //   onToggle: (val) {
                                  //     curdoc.reference
                                  //         .update({"status": "success"});
                                  //     setState(() {
                                  //       status = val;
                                  //     });
                                  //   },
                                  // ),
                                  ElevatedButton(
                                      onPressed: () {
                                        curdoc.reference
                                            .update({"status": "success"});
                                      },
                                      child: const Text("Give premium")),
                                  ElevatedButton(
                                    onPressed: () {
                                      curdoc.reference
                                          .update({"status": "waiting"});
                                    },
                                    child: const Text(
                                      "keep waiting",
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        // curdoc.reference
                                        //     .collection("seller item")
                                        //     .get()
                                        //     .then((value) {
                                        //       value.g
                                        //     });
                                        // curdoc.reference.collection("")
                                        curdoc.reference.delete().then((value) {
                                          FirebaseFirestore.instance
                                              .collection("All items")
                                              .where("seller_id",
                                                  isEqualTo: curdoc['id'])
                                              .get()
                                              .then((nestedvalue) {
                                            if (nestedvalue.size > 0) {
                                              nestedvalue.docs
                                                  .forEach((element) {
                                                element.reference
                                                    .delete()
                                                    .then((value) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "User record successfully deleted",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.amber,
                                                      textColor: Colors.black,
                                                      fontSize: 16.0);
                                                });
                                              });
                                            }
                                          });
                                        });
                                      },
                                      child: const Text("delete user")),
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
