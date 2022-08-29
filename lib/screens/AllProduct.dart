import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

getuserifno(context) {
  AwesomeDialog(
          context: context,
          dialogBackgroundColor: Colors.white,
          dialogType: DialogType.SUCCES,
          borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
          width: 380,
          buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          body: Column(
            children: [
              const Text('complete this form',
                  style: TextStyle(
                      color: Colors.orange, fontFamily: "new", fontSize: 22)),
            ],
          ),
          btnOkText: "Delete",
          btnCancelText: "cancel",
          showCloseIcon: true,
          btnOkOnPress: () {})
      .show();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: Text("Products"),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('All items')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                return Container(
                  margin: const EdgeInsets.all(12),
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot curdoc = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                child: Hero(
                                  tag: index,
                                  child: Image(
                                    image: NetworkImage(curdoc["image link"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Product: ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                            curdoc["item name"],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Des: ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                            curdoc["item description"],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "By: ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          curdoc["business_name"],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          AwesomeDialog(
                                              context: context,
                                              dialogBackgroundColor:
                                                  Colors.white,
                                              dialogType: DialogType.SUCCES,
                                              borderSide: BorderSide(
                                                  color: Colors.blue[900]!,
                                                  width: 2),
                                              width: 380,
                                              buttonsBorderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(2)),
                                              headerAnimationLoop: false,
                                              animType: AnimType.BOTTOMSLIDE,
                                              body: Column(
                                                children: [
                                                  const Text(
                                                      'Are your sure you want delet product.?',
                                                      style: TextStyle(
                                                          color: Colors.orange,
                                                          fontFamily: "new",
                                                          fontSize: 22)),
                                                ],
                                              ),
                                              btnOkText: "Delete",
                                              btnCancelText: "cancel",
                                              showCloseIcon: true,
                                              btnOkOnPress: () {
                                                curdoc.reference.delete();
                                              }).show();
                                        },
                                        child: const Text(
                                          "delet product",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
