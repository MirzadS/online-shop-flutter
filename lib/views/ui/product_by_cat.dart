import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/controllers/product_provider.dart';
import 'package:online_shop/views/shared/category_btn.dart';
import 'package:online_shop/views/shared/custom_spacer.dart';
import 'package:provider/provider.dart';

import '../shared/appstyle.dart';
import '../shared/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKids();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/top_image.png'), fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(text: 'Men Shoes'),
                      Tab(text: 'Woman Shoes'),
                      Tab(text: 'Kids Shoes'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.185,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(male: productNotifier.male),
                    LatestShoes(male: productNotifier.female),
                    LatestShoes(male: productNotifier.kids),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double value = 0;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.84,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 5,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text('Filter', style: appStyle(40, Colors.black, FontWeight.bold)),
                  const CustomSpacer(),
                  Text('Gender', style: appStyle(20, Colors.black, FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      CategoryBtn(
                        label: 'Men',
                        buttonClr: Colors.black,
                      ),
                      CategoryBtn(
                        label: 'Woman',
                        buttonClr: Colors.grey,
                      ),
                      CategoryBtn(
                        label: 'Kids',
                        buttonClr: Colors.grey,
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Category',
                    style: appStyle(20, Colors.black, FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      CategoryBtn(
                        label: 'Shoes',
                        buttonClr: Colors.black,
                      ),
                      CategoryBtn(
                        label: 'Apparels',
                        buttonClr: Colors.grey,
                      ),
                      CategoryBtn(
                        label: 'Accessori',
                        buttonClr: Colors.grey,
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Price',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Slider(
                    value: value,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    divisions: 50,
                    label: value.toString(),
                    onChanged: (double value) {
                      // setState(() {
                      //   value = value;
                      // });
                    },
                  ),
                  const CustomSpacer(),
                  Text(
                    'Brand',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 80,
                    child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Image.asset(
                                brand[index],
                                height: 60,
                                width: 80,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
