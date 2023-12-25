import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/components/colors.dart';

// ignore: must_be_immutable
class CartWidget extends StatefulWidget {
  CartWidget({
    super.key,
    required this.title,
    required this.price,
    required this.img,
    required this.onDelete,
    required this.items,
    required this.onIncrease,
    required this.onDecrease,
    required this.sellerId,
    required this.productId,
  });
  final String title;
  String price;
  final String img;
  final String items;
  final String sellerId;
  final String productId;
  final Function() onDelete;
  final Function() onIncrease;
  final Function() onDecrease;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
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
                        widget.onDecrease();
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
                      widget.items,
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
                        widget.onIncrease();
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
                      widget.onDelete();
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColor.fontColor,
                      size: 24,
                    ),
                  ),
                  Text(
                    widget.price,
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
