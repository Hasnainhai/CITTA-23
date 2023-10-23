import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/custom_field.dart';
import '../../../res/components/roundedButton.dart';
import '../../../res/components/widgets/toggle_widget.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

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
        title: Text(
          "Add New Card",
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.fontColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              const VerticalSpeacing(20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Image.asset('images/addCard.png'),
              ),
              const VerticalSpeacing(18),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                color: AppColor.whiteColor,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      const TextFieldCustom(
                        maxLines: 1,
                        text: 'Card Name',
                        hintText: 'Hasnain haider',
                      ),
                      const TextFieldCustom(
                        maxLines: 1,
                        text: 'Card Number',
                        hintText: '71501 90123 **** ****',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.37,
                            child: const TextFieldCustom(
                              maxLines: 1,
                              text: 'Expiry Date',
                              hintText: '01/04/2028',
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.37,
                            child: const TextFieldCustom(
                              maxLines: 2,
                              text: 'CVV',
                              hintText: '1214',
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(20.0),
                      const ToggleWidget(
                        title: 'Remember My Card Details',
                      ),
                      const VerticalSpeacing(20.0),
                      RoundedButton(
                          title: 'Add Card',
                          onpress: () {
                            Navigator.pushNamed(
                                context, RoutesName.paymentScreen);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
