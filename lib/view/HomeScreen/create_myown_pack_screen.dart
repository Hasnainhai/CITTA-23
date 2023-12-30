import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/Checkout/widgets/card_checkout_screen.dart';
import 'package:citta_23/view/HomeScreen/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/colors.dart';
import 'widgets/homeCard.dart';

class CreateOwnPackScreen extends StatefulWidget {
  const CreateOwnPackScreen({super.key});

  @override
  State<CreateOwnPackScreen> createState() => _CreateOwnPackScreenState();
}

class _CreateOwnPackScreenState extends State<CreateOwnPackScreen> {
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  bool isTrue = true;
  List<Map<String, dynamic>> productList = [];
  double totalSalePrice = 0.0;
  String totalSalePriceString = '0';
  double calculateTotalSalePrice(List<Map<String, dynamic>> productList) {
    double totalSalePrice = 0;

    for (var product in productList) {
      if (product['salePrice'] != null &&
          product['salePrice'].toString().isNotEmpty) {
        totalSalePrice += double.parse(product['salePrice'].toString());
      }
    }

    return totalSalePrice;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection('products').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          'id': qn.docs[i]['id'],
          'sellerId': qn.docs[i]['sellerId'],
          'imageUrl': qn.docs[i]['imageUrl'],
          'title': qn.docs[i]['title'],
          'price': qn.docs[i]['price'],
          'salePrice': qn.docs[i]['salePrice'],
          'detail': qn.docs[i]['detail'],
          'weight': qn.docs[i]['weight'],
        });
      }
    });
    return qn.docs;
  }

  void addToCart(String img, String title, String dPrice, String sellerId,
      String productId) async {
    productList.add({
      'id': productId,
      'sellerId': sellerId,
      'imageUrl': img,
      'title': title,
      'salePrice': dPrice,
    });

    // Calculate the total sale price after adding the new product
    double totalSalePrice = calculateTotalSalePrice(productList);
    setState(() {
      totalSalePriceString = totalSalePrice.toString();
    });

    // Update or use the totalSalePriceString as needed
    print('Total Sale Price after adding: $totalSalePriceString');

    Utils.toastMessage('Successfully added to cart');
  }

  @override
  initState() {
    super.initState();
    fetchProducts();
  }

  bool firstButton = true;
  bool secondButton = false;

  bool thirdButton = false;

  bool fourthButton = false;

  bool fifthButton = false;

  bool sixButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: Text(
          "Create My Pack",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 9,
        color: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    var item = productList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 4.0,
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColor.buttonTxColor,
                          image: DecorationImage(
                            image: NetworkImage(item['imageUrl']),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    totalSalePriceString, // Display total price
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColor.buttonTxColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => CardCheckOutScreen(
                            productType: "create own pack",
                            productList: productList,
                            subTotal: totalSalePriceString,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: AppColor.buttonTxColor,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<DocumentSnapshot> createList = snapshot.data?.docs ?? [];
              debugPrint(
                  "..................this is for checking the created list $createList");

              return GridView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: createList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5, // Horizontal spacing
                  mainAxisSpacing: 10, // Vertical spacing
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  DocumentSnapshot productSnapshot = createList[index];
                  Map<String, dynamic> productData =
                      productSnapshot.data() as Map<String, dynamic>;
                  debugPrint(
                      "..........................This is the map: $productData ");
                  return HomeCard(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailScreen(
                              title: productData['title'].toString(),
                              imageUrl: productData['imageUrl'],
                              price: productData['price'].toString(),
                              salePrice: productData['salePrice'].toString(),
                              productId: productData['id'].toString(),
                              sellerId: productData['sellerId'].toString(),
                              weight: productData['weight'].toString(),
                              detail: productData['detail'].toString(),
                            );
                          },
                        ),
                      );
                    },
                    sellerId: productData['sellerId'],
                    productId: productData['id'],
                    name: productData['title'].toString(),
                    price: productData['salePrice'].toString(),
                    dPrice: productData['price'].toString(),
                    borderColor: AppColor.buttonBgColor,
                    fillColor: AppColor.appBarButtonColor,
                    cartBorder: isTrue
                        ? AppColor.appBarButtonColor
                        : AppColor.buttonBgColor,
                    img: productData['imageUrl'],
                    iconColor: AppColor.buttonBgColor,
                    addCart: () {
                      setState(() {
                        addToCart(
                            productData['imageUrl'],
                            productData['title'].toString(),
                            productData['price'].toString(),
                            productData['sellerId'],
                            productData['id']);
                      });
                    },
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
