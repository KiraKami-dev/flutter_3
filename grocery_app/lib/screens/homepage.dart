import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
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
    Size size = Utils(context).getsize;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:24.0),
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
    );
  }
}
