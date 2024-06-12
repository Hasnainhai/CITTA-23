import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:citta_23/res/consts/firebase_const.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/card/card_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/components/colors.dart';

int subTotal = 0;
int d = 0;

// ignore: must_be_immutable
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
  });
  final String title;
  String price;
  final String img;
  int items;
  final String sellerId;
  final String productId;
  final String deletedId;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int? newPrice;
  String? addPrice;

  void increment() {
    setState(() {
      widget.items++;
      // ignore: unused_local_variable
      int listItems = widget.items;
      debugPrint("this is amount of the product${widget.items}");
      int price = int.tryParse(widget.price) ?? 0;
      newPrice = (newPrice ?? price) + price;
      debugPrint("this is sub-total ${widget.sellerId}");
      debugPrint("this is productList$productList");
      subTotal += price;

      updateSalePrice(newPrice!);
      Provider.of<SubTotalModel>(context, listen: false)
          .updateSubTotal(subTotal);

      debugPrint("this is sub-total $subTotal");
    });
  }

  void updateSalePrice(int subTotal) {
    // Iterate through the list, find the product with the specified ID, and update its sale price
    for (int i = 0; i < productList.length; i++) {
      if (productList[i]["imageUrl"] == widget.img) {
        productList[i]["salePrice"] = subTotal.toString();
        productList[i]['weight'] = widget.items.toString();
        break; // Break out of the loop once the update is done
      }
    }
  }

  void decrement() {
    setState(() {
      if (widget.items > 1) {
        widget.items--;

        int price = int.tryParse(widget.price) ?? 0;

        newPrice = (newPrice ?? price) - price;

        subTotal -= price;
        updateSalePrice(newPrice!);

        Provider.of<SubTotalModel>(context, listen: false)
            .updateSubTotal(subTotal);
      } else {
        // Utils.flushBarErrorMessage("Fixed Limit", context);
      }
    });
  }

  Future<void> _deleteProduct(String deleteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(widget.deletedId)
          .delete();
    } catch (e) {
      // ignore: use_build_context_synchronously
      Utils.flushBarErrorMessage('$e', context);
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
                      text: widget.title,
                      style: const TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColor.fontColor,
                      ),
                    ),
                  ),
                ],
              ),
              // Incremental Buttons
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
                          height: 30,
                          width: 30,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                        height: 30,
                        width: 30,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      newPrice == null
                          ? subTotal -= int.parse(widget.price)
                          : subTotal -= newPrice!;
                      items -= 1;
                      _deleteProduct(widget.deletedId);

                      Provider.of<SubTotalModel>(context, listen: false)
                          .updateSubTotal(subTotal);
                      Provider.of<IndexModel>(context, listen: false)
                          .updateIndex(items);
                      _deleteProduct(widget.deletedId);
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColor.fontColor,
                      size: 24,
                    ),
                  ),
                  Text(
                    newPrice == null ? "${widget.price}₹" : "$newPrice₹",
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
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
