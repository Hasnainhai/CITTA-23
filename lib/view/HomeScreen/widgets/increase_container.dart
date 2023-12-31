import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';

class IncreaseContainer extends StatefulWidget {
  const IncreaseContainer(
      {super.key, required this.onPriceChanged, required this.price});
  final Function(int) onPriceChanged;
  final String price;
  @override
  State<IncreaseContainer> createState() => _IncreaseContainerState();
}

class _IncreaseContainerState extends State<IncreaseContainer> {
  int amount = 1;

  void increasement() {
    setState(() {
      amount++;
    });
  }

  void decreasement() {
    if (amount > 1) {
      setState(() {
        amount--;
        updatePrice();
      });
    }
  }

  void updatePrice() {
    final intPrice = int.parse(widget.price);
    final updatedPrice = (intPrice ~/ amount).toString();
    widget.onPriceChanged(int.parse(updatedPrice));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            decreasement();
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
          amount.toString(),
          style: const TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.fontColor,
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        InkWell(
          onTap: () {
            increasement();
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
    );
  }
}
