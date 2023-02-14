import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScrenn";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getsize;
    bool isEmpty = false;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Product on Sale",
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: isEmpty
          // ignore: dead_code
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Image.asset("images/emptybox.png",
                    height: 244,
                    width: 244,),
                    Text(
                      "No product for sale \n Stay tuned!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              // shrinkWrap: true,
              padding: EdgeInsets.zero,
              // physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / (size.height * 0.60),
              children: List.generate(
                4,
                (index) {
                  return const OnSaleWidget();
                },
              ),
            ),
    );
  }
}
