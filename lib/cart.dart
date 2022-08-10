import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MenCart extends StatefulWidget {
  const MenCart({Key? key}) : super(key: key);

  @override
  State<MenCart> createState() => _MenCartState();
}

class _MenCartState extends State<MenCart> {
  // [
  //  Now its time for Firebase database and its desktop version, i think lots emulator version videos are there. but desktop one is bit rare, so i decided to make one. we need flutter package firedart.
  // First you have to login to Firebase and follow the steps.
  // Connect Firebase on main page and come back.
  // ]

  final CollectionReference brands = Firestore.instance.collection("brands");

  // Use an Empty list to get all data saved in firebase
  var brandsList = [];

  @override
  void initState() {
    getBrandsData();
    super.initState();
  }

  void getBrandsData() {
    Future.delayed(const Duration(seconds: 1), () async {
      brandsList = await brands.get();
      print(brandsList);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // total
    num total = brandsList.fold(
        0, (prev, value) => prev + (value["price"] * value["pieces"]));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 203, 203),
      body: Column(
        children: [
          cartAppBar(),
          Container(
            height: 90,
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$$total",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "based on your ${brandsList.length} items",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              // I got the data, i need to map through list to get the details
              children: brandsList.map((brand) {
                return cartListView(brand);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget cartListView(dynamic brand) => Container(
        height: 285,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 214, 219, 219),
          border: Border(
            top: BorderSide(width: 3),
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  width: 170,
                  // color: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Wrap(
                    children: [
                      Text(
                        brand["brand"].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "versace limited 2022",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    cartDetailsContainer(
                      "size",
                      brand["size"],
                      const Border(
                        top: BorderSide(width: 3),
                        bottom: BorderSide(width: 3),
                        right: BorderSide(width: 3),
                      ),
                    ),
                    cartDetailsContainer(
                      "qt",
                      '${brand["pieces"]} pcs',
                      const Border(
                        top: BorderSide(width: 3),
                        bottom: BorderSide(width: 3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${brand["price"] * brand["pieces"]}",
                            // sorry i got an error because i saved price and pieces as string, lets change it. make sure the type is string, number or boolean.

                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            "\$${brand["price"]} per piece",
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 190,
                        width: 148,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 195, 197, 197),
                          border: Border.all(width: 3),
                          image: DecorationImage(
                            image: AssetImage("assets/${brand["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // delete data from firestore for that we need id, follow the step

                            await brands.document(brand.id).delete();
                            // brand.id gives the auto generated ids

                            // popup message
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text(
                                      "Mens brand deleted from the Cart",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )));
                            // make sure to refresh by calling
                            getBrandsData();
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 3),
                                bottom: BorderSide(width: 3),
                              ),
                            ),
                            child: const Icon(Icons.delete, size: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget cartDetailsContainer(String title, String details, BoxBorder border) =>
      Container(
        height: 60,
        width: 85,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: border,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                Text(
                  details,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_downward, size: 18),
          ],
        ),
      );

  Widget cartAppBar() => Padding(
        padding: const EdgeInsets.fromLTRB(18, 30, 18, 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Icon(Icons.arrow_back_ios, size: 18)),
                const Icon(Icons.menu, size: 20),
              ],
            ),
            Text(
              "my cart".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Icon(Icons.shopping_cart, size: 18),
          ],
        ),
      );
}
