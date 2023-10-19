import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/components/colors.dart';
import '../../HomeScreen/widgets/increase_container.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key, required this.title, required this.subtitle, required this.price, required this.img,
  });
  final String title;
  final String subtitle;
  final String price;
  final String img;
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
                child: Image.asset(img),
              ),
              title: Row(
                children: [
                  const SizedBox(width: 30.0),
                  Text.rich(
                    TextSpan(
                      text: '$title \n',
                      style: GoogleFonts.getFont(
                        "Gothic A1",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColor.fontColor,
                        ),
                      ),
                      children:  <TextSpan>[
                        TextSpan(
                          text: subtitle,
                          style:const TextStyle(
                            color: AppColor.grayColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Row(
                  children: [
                    const SizedBox(width: 30.0),
                    IncreaseContainer(),
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.delete_outline,
                    color: AppColor.fontColor,
                    size: 24,
                  ),
                  Text(
                    price,
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
