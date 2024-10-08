import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import '../../res/components/colors.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

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
              color: AppColor.primaryColor,
            )),
        title: const Text(
          "FAQs",
          style: TextStyle(
            fontFamily: 'CenturyGothic',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.fontColor,
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
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. How it will take to delivery?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(12),
                Text(
                  "2. What is refund system?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi.Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(12),
                Text(
                  "3. What is refund system?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi.Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(12),
                Text(
                  "4. What is refund system?",
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.fontColor,
                  ),
                ),
                VerticalSpeacing(8),
                Text(
                  "In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi.Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
