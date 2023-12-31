import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';
import 'widgets/coupon_card.dart';

class PromosOffer extends StatelessWidget {
  const PromosOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Offer & Promos ',
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
            Navigator.pushNamed(
              context,
              RoutesName.dashboardScreen,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpeacing(30.0),
              const Text(
                'You Have 5 Coupons To Use ',
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackColor,
                ),
              ),
              const VerticalSpeacing(20.0),
              CouponCard(
                  ontap: () {
                    Navigator.pushNamed(context, RoutesName.couponDetails);
                  },
                  img: 'images/offer1.png'),
              const VerticalSpeacing(20.0),
              CouponCard(ontap: () {}, img: 'images/offer2.png'),
              const VerticalSpeacing(20.0),
              CouponCard(ontap: () {}, img: 'images/offer3.png'),
              const VerticalSpeacing(20.0),
              CouponCard(ontap: () {}, img: 'images/offer4.png'),
              const VerticalSpeacing(20.0),
              CouponCard(ontap: () {}, img: 'images/offer1.png'),
              const VerticalSpeacing(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
