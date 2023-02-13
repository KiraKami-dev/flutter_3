import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {Key? key,
      required this.salePrice,
      required this.price,
      required this.isOnSale,
      required this.textPrice})
      : super(key: key);
  final double salePrice, price;
  final bool isOnSale;
  final String textPrice;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnSale ? salePrice : price;
    return FittedBox(
      child: Row(children: [
        TextWidget(
          text: "\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}",
          color: Colors.green,
          textSize: 20,
          // isTitle: true,
          // isTitle: true,
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale ? true : false,
          child: Text(
            "\$${(price * int.parse(textPrice)).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 18,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        )
      ]),
    );
  }
}
