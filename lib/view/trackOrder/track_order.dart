import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/trackOrder/widgets/productDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];
  final bool isTrue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'My Order Details ',
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.myOrder);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
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
                const Text(
                  '   Order id #30398505202',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: OrderTracker(
                    status: Status.delivered,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                ),
                const VerticalSpeacing(20.0),
                // This is not favourite list card but i use it in order track in Prodcut details
                const ProductDetailsWidget(
                  img: 'images/Arnotts.png',
                  title: 'Arnotts grans',
                  subTitle: 'Form The Farmer',
                  price: '3 KG',
                  productPrice: '\$30',
                  procustAverate: '3x',
                  id: '',
                  productId: '',
                ),
                const VerticalSpeacing(20.0),
                const ProductDetailsWidget(
                  img: 'images/cauliflower.png',
                  title: 'cauliflower',
                  subTitle: 'Form The Farmer',
                  price: '5 KG',
                  productPrice: '\$20',
                  procustAverate: '6x',
                  id: '',
                  productId: '',
                ),
                const VerticalSpeacing(20.0),
                const ProductDetailsWidget(
                  img: 'images/girlGuide.png',
                  title: 'girlGuide',
                  subTitle: 'Form The Farmer',
                  price: '2 KG',
                  productPrice: '\$80',
                  procustAverate: '9x',
                  id: '',
                  productId: '',
                ),

                const VerticalSpeacing(30.0),
                const ListTile(
                  title: Text(
                    'Total Amount',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                  trailing: Text(
                    '\$130',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const ListTile(
                  title: Text(
                    'Paid From',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                  trailing: Text(
                    'Credit Card',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
