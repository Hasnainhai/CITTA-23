import 'package:citta_23/routes/routes_name.dart';
import 'package:citta_23/view/HomeScreen/new_items.dart';
import 'package:citta_23/view/filter/filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/components/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List resultList = [];
  List _allResults = [];

  getProductsStream() async {
    var data = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('title')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChange);
  }

  _onSearchChange() {
    print('on Search......');
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getProductsStream();
    super.didChangeDependencies();
  }

  void searchResultList() {
    var showResult = [];
    if (_searchController.text != '') {
      for (var clientsnapShot in _allResults) {
        var name = clientsnapShot['title'].toString().toLowerCase();
        if (name.contains(_searchController.text.toString().toLowerCase())) {
          showResult.add(clientsnapShot);
        } else {
          showResult = List.from(_allResults);
          setState(() {
            resultList = showResult;
          });
        }
      }
    }
  }

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
      body: ListView(
        children: [
          Padding(
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
                        controller: _searchController,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: InkWell(
                          onTap: () {
                            String title = 'Search results...';
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewItemsScreen(
                                title: title,
                              );
                            }));
                          },
                          child: Text(
                            _allResults[index]['title'],
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
