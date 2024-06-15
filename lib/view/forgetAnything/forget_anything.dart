import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/HomeScreen/widgets/homeCard.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';
import '../Checkout/widgets/card_checkout_screen.dart';

class ForgetAnything extends StatelessWidget {
  const ForgetAnything({
    super.key,
    required this.productList,
    required this.subTotal,
  });

  final List<Map<String, dynamic>> productList;
  final String subTotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(125),
        child: AppBar(
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
            ),
          ),
          title: const Text(
            "Forget Anything?",
            style: TextStyle(
              fontFamily: 'CenturyGothic',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
          flexibleSpace: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "You haven't finished checking out yet.\nDon't miss out anything?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColor.fontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalSpeacing(16),
              ],
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 4 / 4,
        ),
        itemBuilder: (context, index) {
          final product = productList[index];
          return HomeCard(
            name: product['title'],
            price: '\$${product['salePrice']}',
            dPrice: '\$${product['salePrice']}',
            borderColor: AppColor.primaryColor,
            fillColor: AppColor.bgColor,
            img: product['imageUrl'],
            iconColor: AppColor.primaryColor,
            ontap: () {},
            addCart: () {},
            productId: '',
            sellerId: '',
            productRating: 0.0,
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 30.0),
            Expanded(
              child: Container(
                height: double.infinity,
                color: const Color(0xffF7F7F7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Text(
                      subTotal,
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.grayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) {
                      return CardCheckOutScreen(
                        productType: 'cart',
                        productList: productList,
                        subTotal: subTotal,
                      );
                    }),
                  );
                },
                child: Container(
                  height: double.infinity,
                  color: AppColor.primaryColor,
                  child: const Center(
                    child: Text(
                      'Continue to checkout',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
