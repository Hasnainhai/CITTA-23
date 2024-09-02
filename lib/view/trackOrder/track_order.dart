// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/trackOrder/widgets/productDetailsWidget.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.weight,
    required this.items,
    required this.price,
    required this.orderId,
    required this.img,
  });
  final String title;
  final String date;
  final String status;
  final String weight;
  final String items;
  final String price;
  final String orderId;
  final String img;

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  List<TextDto> orderList = [];
  List<TextDto> shippedList = [];
  List<TextDto> outOfDeliveryList = [];
  List<TextDto> deliveredList = [];
  final bool isTrue = true;

  Status _getOrderStatus(String status) {
    switch (status) {
      case "pending":
        return Status.shipped;
      case "processing":
        return Status.outOfDelivery;
      case "Delivered":
        return Status.delivered;
      default:
        return Status.shipped; // or some default status
    }
  }

  @override
  Widget build(BuildContext context) {
    orderList.clear();
    orderList.add(TextDto(
      "Your order has been placed",
      widget.date,
    ));
    if (widget.status == "pending") {
      shippedList.clear();
      shippedList.add(TextDto("Your order has been ", widget.status));
    } else {
      shippedList.clear();
      shippedList.add(TextDto("Your order has been ", "out for delivery"));
    }
    if (widget.status != "pending") {
      outOfDeliveryList.clear();
      outOfDeliveryList.add(
        TextDto("Your order has been", "Processing"),
      );
    }
    if (widget.status == 'Delivered') {
      deliveredList.clear();

      deliveredList.add(
        TextDto("Your order has been ", "delivered"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'My Order Details ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.primaryColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          color: AppColor.whiteColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20.0),
                Text(
                  widget.orderId,
                  style: const TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: OrderTracker(
                    subTitleTextStyle: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                    headingTitleStyle: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.fontColor,
                    ),
                    status: _getOrderStatus(widget.status),
                    headingDateTextStyle: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.transparent,
                    ),
                    subDateTextStyle: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.primaryColor,
                    ),
                    activeColor: AppColor.primaryColor,
                    inActiveColor: Colors.grey[300],
                    orderTitleAndDateList: orderList,
                    shippedTitleAndDateList: shippedList,
                    outOfDeliveryTitleAndDateList: outOfDeliveryList,
                    deliveredTitleAndDateList: deliveredList,
                  ),
                ),
                const Text(
                  '   Product Details',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor,
                  ),
                ),
                const VerticalSpeacing(8.0),
                // This is not favourite list card but I use it in order track in Product details
                ProductDetailsWidget(
                  img: widget.img,
                  title: widget.title,
                  subTitle: widget.weight,
                  price: widget.weight,
                  productPrice: widget.price,
                  procustAverate: widget.items,
                  id: widget.orderId,
                  productId: widget.orderId,
                ),
                const VerticalSpeacing(30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
