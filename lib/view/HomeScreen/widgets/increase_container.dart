import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class IncreaseContainer extends StatefulWidget {
  IncreaseContainer({super.key});

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

  decreasement() {
    setState(() {
      amount--;
    });
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
