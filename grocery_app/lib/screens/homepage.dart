import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

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
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    final themeState = utils.getTheme;
    Size size = Utils(context).getsize;
    return Scaffold(
      body: Column(
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
            onPressed: () {},
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
                    TextWidget(
                      text: "On sale".toUpperCase(),
                      color: Colors.red,
                      textSize: 22,
                      isTitle: true,
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
                      return OnSaleWidget();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
