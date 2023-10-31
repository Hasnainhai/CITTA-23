import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/HomeScreen/Search/widgets/recent_search_tile.dart';
import 'package:citta_23/view/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RoutesName.dashboardScreen,
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.fontColor,
            )),
        title: Text(
          "Search",
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
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    width: (MediaQuery.of(context).size.width) - 90,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Search Here",
                        helperStyle: TextStyle(color: AppColor.grayColor),
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 50,
                    decoration:
                        const BoxDecoration(color: AppColor.primaryColor),
                    child: IconButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const FilterPopUp(),
                          );
                        },
                        icon: const Icon(
                          Icons.tune_sharp,
                          color: AppColor.buttonTxColor,
                        )),
                  ),
                ],
              ),
              const VerticalSpeacing(20),
              Text(
                "Recent Searches",
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.fontColor,
                  ),
                ),
              ),
              const VerticalSpeacing(10),
              const RecentSearchTile(searchHistory: "Vegetables"),
              const VerticalSpeacing(10),
              const RecentSearchTile(searchHistory: "Raduni Lal Morich"),
              const VerticalSpeacing(10),
              const RecentSearchTile(searchHistory: "ACI Lobon"),
              const VerticalSpeacing(10),
              const RecentSearchTile(searchHistory: "Meat"),
              const VerticalSpeacing(10),
              const RecentSearchTile(searchHistory: "Dog Dry Food"),
              const VerticalSpeacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
