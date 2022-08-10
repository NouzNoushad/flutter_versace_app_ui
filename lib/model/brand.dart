class Brands {
  final String fullImage, image, brand, size;
  final double price;
  double rating;
  bool isFavorite;
  int pieces;

  Brands({
    required this.fullImage,
    required this.image,
    required this.brand,
    required this.size,
    required this.price,
    required this.rating,
    required this.isFavorite,
    required this.pieces,
  });
}

final BrandLists = [
  Brands(
    fullImage: "jacket_men.jpg",
    image: "jacket.png",
    brand: "Silver Baroque Jacket",
    size: "44-XS",
    price: 970,
    rating: 4.2,
    isFavorite: false,
    pieces: 1,
  ),
  Brands(
    fullImage: "shorts_men.jpg",
    image: "shorts.png",
    brand: "Silver Baroque Shorts",
    size: "48-L",
    price: 800,
    rating: 3.8,
    isFavorite: false,
    pieces: 1,
  ),
  Brands(
    fullImage: "shirt_men.jpg",
    image: "shirt.png",
    brand: "Silver Baroque Shirt",
    size: "46-M",
    price: 880,
    rating: 4.3,
    isFavorite: false,
    pieces: 1,
  ),
  Brands(
    fullImage: "tshirt_men.jpg",
    image: "tshirt.png",
    brand: "Silver Baroque T-Shirt",
    size: "50-XL",
    price: 990,
    rating: 4.5,
    isFavorite: false,
    pieces: 1,
  ),
];
