import 'package:flutter/material.dart';
import 'package:flutter_men_collection/model/brand.dart';

import 'cart.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Brands> brands = BrandLists;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 198, 203, 203),
      body: Column(
        children: [
          homeAppBar(),
          Container(
            height: 90,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Column(
              children: [
                const Text(
                  "versace limited 2022",
                  style: TextStyle(
                    height: 1, // remove excess padding
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 405,
                  // color: Colors.white,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 9,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      return GestureDetector(
                        onTap: () {
                          // if i click on image take me to details page
                          // Add some brand details
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenClothingDetails(brand: brand)),
                          );
                        },
                        child: Container(
                          // color: Colors.grey,
                          child: Image.asset(
                            "assets/${brand.fullImage}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }, // create a model and grab data
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget homeAppBar() => Padding(
        padding: const EdgeInsets.fromLTRB(18, 30, 18, 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.arrow_back_ios, size: 18),
                Icon(Icons.menu, size: 20),
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
