import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_men_collection/model/brand.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'cart.dart';

class MenClothingDetails extends StatefulWidget {
  final Brands brand;
  const MenClothingDetails({Key? key, required this.brand}) : super(key: key);

  @override
  State<MenClothingDetails> createState() => _MenClothingDetailsState();
}

class _MenClothingDetailsState extends State<MenClothingDetails> {
  // firebase
  final CollectionReference brands = Firestore.instance.collection("brands");

  List<String> sizes = ["44-XS", "46-M", "48-L", "50-XL"];
  String? brandSize;

  @override
  void initState() {
    brandSize = widget.brand.size;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 203, 203),
      body: Column(
        children: [
          detailsAppBar(),
          Container(
            height: 85,
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.filter_alt_outlined,
                    color: Colors.white, size: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "2022 - full - winter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "upcoming releases",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              widget.brand.brand.toUpperCase(),
              style: const TextStyle(
                height: 1,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 3),
                bottom: BorderSide(width: 3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // flutter rating bar
                    RatingBar.builder(
                      initialRating: widget.brand.rating,
                      allowHalfRating: true,
                      itemSize: 14,
                      direction: Axis.horizontal,
                      onRatingUpdate: (rating) {},
                      itemCount: 5,
                      itemBuilder: (context, _) {
                        return const Icon(Icons.star, color: Colors.black);
                      },
                    ),
                    const Text(
                      "10 reviews",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$${widget.brand.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.brand.isFavorite = !widget.brand.isFavorite;
                        });
                      },
                      child: widget.brand.isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 25,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                              size: 25,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(18, 18, 10, 18),
                      child: Text(
                        "size: ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width - 56,
                      // color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                brandSize = sizes[index];
                              });
                            },
                            child: Container(
                              width: 65,
                              height: 28,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.black),
                              child: Text(
                                sizes[index],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 180,
                      width: 20,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 3),
                          bottom: BorderSide(width: 3),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            border: Border.all(width: 3),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/${widget.brand.image}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 160,
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 3),
                              bottom: BorderSide(width: 3),
                              right: BorderSide(width: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "selected color: print",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 180,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 3),
                                bottom: BorderSide(width: 3),
                              ),
                            ),
                            child: const Text(
                              "Crafted from exceptional quality materials, this design is inspired by Donatella Versaces with love and compassion.",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 100,
                  color: Colors.black,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // I need to change size when i click on each sizes
                      Text(
                        "size: $brandSize",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "color: print",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // modify this code because it decrement to zero, which will cause trouble multiplying with price
                                  if (widget.brand.pieces <= 1) {
                                    return;
                                  }
                                  widget.brand.pieces--;
                                });
                              },
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black,
                                child: Icon(Icons.remove,
                                    size: 18, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.brand.pieces}",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.brand.pieces++;
                                });
                              },
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black,
                                child: Icon(Icons.add,
                                    size: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        detailsAddButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsAddButton() => Row(
        children: [
          const Icon(Icons.arrow_forward, size: 25),
          Container(
            height: double.infinity,
            child: TextButton(
              onPressed: () async {
                // Add men clothing data to Firebase
                await brands.add({
                  // add datas in map format
                  'brand': widget.brand.brand,
                  'image': widget.brand.image,
                  'pieces': widget.brand.pieces,
                  'price': widget.brand.price,
                  'size': brandSize,
                });
                // pop up message using snackbar
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      "New men brand added to the Cart",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )));
              },
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.black.withOpacity(0.2)),
              ),
              child: const Text(
                "add now",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      );

  Widget detailsAppBar() => Padding(
        padding: const EdgeInsets.fromLTRB(18, 30, 18, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      // back to homepage
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, size: 18)),
                const Icon(Icons.menu, size: 20),
              ],
            ),
            Text(
              "men clothing".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            GestureDetector(
                onTap: () {
                  // navigate to cart page
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MenCart()),
                  );
                },
                child: const Icon(Icons.shopping_cart, size: 18)),
          ],
        ),
      );
}
