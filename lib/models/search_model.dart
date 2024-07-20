class Product {
  final String id;
  final String sellerId;
  final String title;
  final List<String> imageUrl;
  final String price;
  final String detail;
  final List<String> colors;
  final List<String> sizes;
  final String weight;
  final String discount;
  final double averageReview;
  final String category; // Added category field
  final bool isFashion;

  Product({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.detail,
    this.colors = const ["N/A"],
    this.sizes = const ["N/A"],
    this.weight = "N/A",
    this.discount = "N/A",
    this.averageReview = 0.0,
    required this.category, // Initialize category
    required this.isFashion,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, bool isFashion) {
    return Product(
      id: data['id'] ?? '',
      sellerId: data['sellerId'] ?? '',
      title: data['title'] ?? 'No Title',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 'N/A',
      detail: data['detail'] ?? 'N/A',
      colors:
          (data['color'] != null) ? List<String>.from(data['color']) : ["N/A"],
      sizes: (data['size'] != null) ? List<String>.from(data['size']) : ["N/A"],
      weight: data['weight'] ?? 'N/A',
      discount: data['discount'] ?? 'N/A',
      averageReview: (data['averageReview'] != null)
          ? data['averageReview'].toDouble()
          : 0.0,
      category: data['category'] ?? 'N/A', // Assign category
      isFashion: isFashion,
    );
  }

  String get salePrice {
    if (isFashion) {
      return price;
    }
    // Calculation for sale price if needed
    return price;
  }

  String get discountPrice {
    if (isFashion) {
      return "0";
    }
    // Calculation for discount price if needed
    return "0";
  }
}
