import 'package:citta_23/view/Checkout/widgets/myCheckout.dart';
import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class AddressCheckOutWidget extends StatefulWidget {
  const AddressCheckOutWidget({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.titleColor,
    required this.title,
    required this.phNo,
    required this.address,
  });
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String title;
  final String phNo;
  final String address;

  @override
  State<AddressCheckOutWidget> createState() => _AddressCheckOutWidgetState();
}

class _AddressCheckOutWidgetState extends State<AddressCheckOutWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: widget.bgColor,
          border: Border.all(width: 2, color: widget.borderColor)),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyCheckBox(),
            const SizedBox(width: 15.0),
            Text.rich(
              TextSpan(
                text: '${widget.title} \n ',
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.titleColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '(${widget.phNo}\n',
                    style: const TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  TextSpan(
                    text: widget.address,
                    style: const TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
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
