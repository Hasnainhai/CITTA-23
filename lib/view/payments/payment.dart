import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

bool firstButton = true;
bool secondButton = false;

class _PaymentState extends State<Payment> {
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
        title: const Text(
          "Payment",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.fontColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpeacing(30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Card",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.addCardScreen);
                    },
                    child: Container(
                      height: 32.0,
                      width: 32.0,
                      color: AppColor.primaryColor,
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpeacing(20.0),
            SizedBox(
              height: 176,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Image.asset('images/masterCart.png'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Image.asset('images/visaCard.png'),
                  ),
                ],
              ),
            ),
            const VerticalSpeacing(46.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Other Payment Options",
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.fontColor,
                    ),
                  ),
                  const VerticalSpeacing(20.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        firstButton = !firstButton;
                        secondButton = false;
                      });
                    },
                    child: Container(
                      height: 85,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: firstButton
                              ? AppColor.primaryColor
                              : const Color(0xffEEEEEE),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Container(
                            height: 60.0,
                            width: 60.0,
                            color: const Color(0xffEEEEEE),
                            child: Center(
                              child: SizedBox(
                                height: 40.0,
                                width: 40.0,
                                child: Image.asset(
                                  'images/paypal.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 25.0),
                          const Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Paypal   \n',
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.fontColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'MyPaypal@gmail.com',
                                  style: TextStyle(
                                    color: AppColor.fontColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(20.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        firstButton = false;
                        secondButton = !secondButton;
                      });
                    },
                    child: Container(
                      height: 85,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: secondButton
                              ? AppColor.primaryColor
                              : const Color(0xffEEEEEE),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Container(
                            height: 60.0,
                            width: 60.0,
                            color: const Color(0xffEEEEEE),
                            child: Center(
                              child: SizedBox(
                                height: 40.0,
                                width: 40.0,
                                child: Image.asset(
                                  'images/cash.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 25.0),
                          const Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Cash On Delivery   \n',
                                  style: TextStyle(
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.fontColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pay in Cash',
                                  style: TextStyle(
                                    color: AppColor.fontColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
