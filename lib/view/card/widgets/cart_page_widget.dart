import 'package:citta_23/models/index_model.dart';
import 'package:citta_23/models/sub_total_model.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/card/card_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../res/components/colors.dart';

int subTotal = 0;

// ignore: must_be_immutable

class CartWidget extends StatefulWidget {
  CartWidget({
    super.key,
    required this.title,
    required this.price,
    required this.img,
    required this.onDelete,
    required this.items,
    required this.sellerId,
    required this.productId,
  });
  final String title;
  String price;
  final String img;
  int items;
  final String sellerId;
  final String productId;
  final Function() onDelete;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int? newPrice;
  String? addPrice;
  void increment() {
    setState(() {
      widget.items++;

      int price = int.parse(widget.price);
      newPrice = (newPrice ?? int.parse(widget.price)) + price;
      totalPrice = newPrice;
      subTotal += totalPrice!;
      debugPrint("this is sub-total$subTotal");

      // Notify listeners about the change
      Provider.of<SubTotalModel>(context, listen: false)
          .updateSubTotal(subTotal);
    });
  }

  void decrement() {
    setState(() {
      if (widget.items > 1) {
        widget.items--;
        int price = int.parse(widget.price);
        newPrice = (newPrice ?? int.parse(widget.price)) - price;
        subTotal -= newPrice!;
        debugPrint("this decrement subtotal$subTotal");

        // Notify listeners about the change
        Provider.of<SubTotalModel>(context, listen: false)
            .updateSubTotal(subTotal);
      } else {
        Utils.flushBarErrorMessage("Fixed Limit", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
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
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColor.fontColor,
                        ),
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
                          height: 34,
                          width: 34,
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
                      width: 18,
                    ),
                    Text(
                      widget.items.toString(),
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        increment();
                      },
                      child: Container(
                        height: 34,
                        width: 34,
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
                      Provider.of<SubTotalModel>(context, listen: false)
                          .updateSubTotal(subTotal);
                      Provider.of<IndexModel>(context, listen: false)
                          .updateIndex(items);
                      widget.onDelete();
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColor.fontColor,
                      size: 24,
                    ),
                  ),
                  Text(
                    newPrice == null ? widget.price : newPrice.toString(),
                    style: GoogleFonts.getFont(
                      "Gothic A1",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColor.fontColor,
                      ),
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
