import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: const Text(
          "Contact Us",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.primaryColor,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize:
              Size.fromHeight(1.0), // Set the height of the bottom border
          child: Divider(
            height: 1.0, // Set the height of the Divider line
            color: AppColor.primaryColor, // Set the color of the Divider line
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: AppColor.primaryColor,
                  ),
                ),
                subtitle: const Text(
                  "+8801710000000",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                title: const Text(
                  "+8801710000000",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  child: const Icon(
                    Icons.email,
                    color: AppColor.primaryColor,
                  ),
                ),
                title: const Text(
                  "Hello@gmail.com",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColor.primaryColor,
                  ),
                ),
                subtitle: const Text(
                  "Dhaka, Bangladesh",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                title: const Text(
                  "26/C Mohammadpur",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
