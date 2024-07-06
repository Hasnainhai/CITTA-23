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
    required this.isSelect,
    required this.ontapSelect,
  });
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String title;
  final String phNo;
  final String address;
  final bool isSelect;
  final Function ontapSelect;

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
        border: Border.all(width: 2, color: widget.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                widget.ontapSelect();
              },
              child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      color: widget.isSelect
                          ? AppColor.primaryColor
                          : Colors.transparent,
                    ),
                  )),
            ),
            const SizedBox(width: 15.0),
            Text.rich(
              TextSpan(
                text: widget.title.length > 13
                    ? '${widget.title.substring(0, 13)}...\n'
                    : '${widget.title}\n',
                style: TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.titleColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${widget.phNo}\n',
                    style: const TextStyle(
                      color: AppColor.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                  TextSpan(
                    text: widget.address.length > 20
                        ? '${widget.address.substring(0, 20)}...\n'
                        : '${widget.address}\n',
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
