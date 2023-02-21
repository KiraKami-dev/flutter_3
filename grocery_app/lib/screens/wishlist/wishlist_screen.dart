import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/screens/wishlist/wishlisht_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/WislListScreen';
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getsize;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: TextWidget(
              text: "WishList",
              color: color,
              textSize: 24,
              isTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ),
              ),
            ]),
        body: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ));
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
