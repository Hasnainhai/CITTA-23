import 'package:citta_23/res/components/colors.dart';
import 'package:flutter/material.dart';

class RecentSearchTile extends StatelessWidget {
  final String searchHistory;
  const RecentSearchTile({super.key, required this.searchHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                searchHistory,
                style: const TextStyle(
                  fontFamily: 'CenturyGothic',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grayColor,
                ),
              ),
              const Icon(
                Icons.arrow_outward,
                color: AppColor.primaryColor,
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
