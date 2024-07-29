// ignore_for_file: use_build_context_synchronously

import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/components/colors.dart';

int subTotal = 0;
int d = 0;

class CartWidget extends StatefulWidget {
  CartWidget({
    super.key,
    required this.title,
    required this.price,
    required this.img,
    required this.items,
    required this.sellerId,
    required this.productId,
    required this.deletedId,
    required this.discount,
  });
  final String title;
  String price;
  final String img;
  int items;
  final String sellerId;
  final String productId;
  final String deletedId;
  String discount;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int? newPrice;
  int? newDiscount;

  void increment() {
    setState(() {
      widget.items++;
      int price = int.tryParse(widget.price) ?? 0;
      int discount = int.tryParse(widget.discount) ?? 0;

      newPrice = (newPrice ?? price) + price;
      newDiscount = (newDiscount ?? discount) + discount;

      subTotal += price;
      d += discount;

      updateSalePrice(newPrice!, newDiscount!);
      Provider.of<SubTotalModel>(context, listen: false)
          .updateSubTotal(subTotal);
      Provider.of<DiscountSum>(context, listen: false).updateDisTotal(d);
      Provider.of<TotalPriceModel>(context, listen: false)
          .updateTotalPrice(subTotal, d);

      debugPrint("Updated sub-total: $subTotal");
      debugPrint("Updated discount: $d");
    });
  }

  void updateSalePrice(int subTotal, int discount) {
    for (int i = 0; i < productList.length; i++) {
      if (productList[i]["imageUrl"] == widget.img) {
        productList[i]["salePrice"] = subTotal.toString();
        productList[i]["discount"] = discount.toString();
        productList[i]["quantity"] = widget.items.toString();

        break;
      }
    }
  }

  void decrement() {
    setState(() {
      if (widget.items > 1) {
        widget.items--;

        int price = int.tryParse(widget.price) ?? 0;
        int discount = int.tryParse(widget.discount) ?? 0;

        newPrice = (newPrice ?? price) - price;
        newDiscount = (newDiscount ?? discount) - discount;

        subTotal -= price;
        d -= discount;

        updateSalePrice(newPrice!, newDiscount!);

        Provider.of<SubTotalModel>(context, listen: false)
            .updateSubTotal(subTotal);
        Provider.of<DiscountSum>(context, listen: false).updateDisTotal(d);
        Provider.of<TotalPriceModel>(context, listen: false)
            .updateTotalPrice(subTotal, d);
      }
    });
  }

  Future<void> _deleteProduct(String deleteId) async {
    try {
      // Retrieve the document to get the price and discount before deletion
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(deleteId)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        int price = int.tryParse(data['salePrice']?.toString() ?? '0') ?? 0;

        // Subtract the price and discount from the totals
        subTotal -= newPrice ?? price;
        d -= int.parse(widget.discount) * widget.items;

        Provider.of<SubTotalModel>(context, listen: false)
            .updateSubTotal(subTotal);
        Provider.of<DiscountSum>(context, listen: false).updateDisTotal(d);
        Provider.of<TotalPriceModel>(context, listen: false)
            .updateTotalPrice(subTotal, d);
        int currentIndex =
            Provider.of<IndexModel>(context, listen: false).items;
        Provider.of<IndexModel>(context, listen: false)
            .updateIndex(currentIndex - 1);
      }

      // Delete the document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(deleteId)
          .delete();
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        shape: const RoundedRectangleBorder(),
        color: AppColor.whiteColor,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: ListTile(
              leading: SizedBox(
                height: 80.0,
                width: 58.0,
                child: FancyShimmerImage(
                  imageUrl: widget.img,
                  boxFit: BoxFit.fill,
                ),
              ),
              title: Row(
                children: [
                  const SizedBox(width: 30.0),
                  Text.rich(
                    TextSpan(
                      text: widget.title.length > 12
                          ? '${widget.title.substring(0, 12)}...'
                          : widget.title,
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.fontColor,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Row(
                  children: [
                    const SizedBox(width: 30.0),
                    InkWell(
                      onTap: () {
                        decrement();
                      },
                      child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.grayColor,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(
                              height: 2,
                              thickness: 2.5,
                              color: AppColor.primaryColor,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.items.toString(),
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.fontColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        increment();
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.grayColor,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _deleteProduct(widget.deletedId);
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColor.fontColor,
                      size: 20,
                    ),
                  ),
                  const VerticalSpeacing(6),
                  Text(
                    newPrice == null ? "${widget.price}₹" : "$newPrice₹",
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.fontColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
