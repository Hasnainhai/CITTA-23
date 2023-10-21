import 'package:citta_23/res/components/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class AddressDetailSceen extends StatefulWidget {
  const AddressDetailSceen({super.key});

  @override
  State<AddressDetailSceen> createState() => _AddressDetailSceenState();
}

class _AddressDetailSceenState extends State<AddressDetailSceen> {
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
          "New Address",
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
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    const TextFieldCustom(maxLines: 1, text: "Full Name"),
                    const TextFieldCustom(maxLines: 1, text: "Phone Number"),
                    const TextFieldCustom(maxLines: 1, text: "Address Link 1"),
                    const TextFieldCustom(maxLines: 1, text: "Address Link 2"),
                    const TextFieldCustom(maxLines: 1, text: "City"),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         Text(
                    //           "State",
                    //           style: GoogleFonts.getFont(
                    //             "Gothic A1",
                    //             textStyle: const TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w400,
                    //               color: AppColor.fontColor,
                    //             ),
                    //           ),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         Container(
                    //           child: TextFormField(
                    //             style: const TextStyle(fontSize: 15),
                    //             decoration: const InputDecoration(
                    //               filled: true,
                    //               fillColor: Color(0xfff1f1f1),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(10)),
                    //                 borderSide:
                    //                     BorderSide(color: Color(0xfff1f1f1)),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(10)),
                    //                 borderSide:
                    //                     BorderSide(color: Color(0xfff1f1f1)),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
