import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/conts.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/feed_item.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/products_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> swipeimg = [
    "images/cat/cabbage.png",
    "images/cat/kyoto.png",
    "images/cat/onion.png"
  ];
  @override
  Widget build(BuildContext context) {
    // final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    // final themeState = utils.getTheme;
    Size size = Utils(context).getsize;
    final productsProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allproduct = productsProviders.getProducts;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: size.height * 0.3,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      swipeimg[index],
                      fit: BoxFit.fitHeight,
                    );
                  },
                  itemCount: swipeimg.length,
                  autoplay: true,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.black,
                      activeColor: Colors.blueAccent,
                    ),
                  ),
                  // control: SwiperControl(),
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            TextButton(
              onPressed: () {
                GlobalMethod.navigateTo(
                    ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: TextWidget(
                text: "View all",
                maxLines: 1,
                color: Colors.blue,
                textSize: 18,
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextWidget(
                          text: "On sale".toUpperCase(),
                          color: Colors.red,
                          textSize: 22,
                          isTitle: true,
                        ),
                      ),
                      const Icon(
                        IconlyBold.discount,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.25,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return const OnSaleWidget();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Our Product",
                    maxLines: 1,
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {
                      GlobalMethod.navigateTo(
                        ctx: context,
                        routeName: FeedScreen.routeName,
                      );
                    },
                    child: TextWidget(
                      text: "Browse all",
                      maxLines: 1,
                      color: Colors.blueAccent,
                      textSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / (size.height * 0.60),
              children: List.generate(
                allproduct.length < 4 ? allproduct.length : 4,
                (index) {
                  return ChangeNotifierProvider.value(
                    value: allproduct[index],
                    child: const FeedWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
