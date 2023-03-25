import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

import '../../services/global_methods.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getsize;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: "Cart (2)",
            color: color,
            textSize: 24,
            isTitle: true,
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethod.warningDialog(
                    title: "Empty Cart",
                    subtitle: 'are you sure?',
                    ftc: () {},
                    context: context,
                    imgadd: "images/logout.png");
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ]),
      body: Column(
        children: [
          _checkcut(size: size, color: color),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: ((context, index) {
                return CartWidget();
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _checkcut({
  required size,
  required color,
}) {
  return SizedBox(
    width: double.infinity,
    height: size.height * 0.08,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: "Order Now",
                  color: Colors.white,
                  textSize: 20,
                ),
              ),
            ),
          ),
          const Spacer(),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                text: "Total \$0.259",
                color: color,
                textSize: 18,
                isTitle: true,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
