import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(
      child: Row(children: [
        TextWidget(
          text: "\$1KG",
          color: Colors.green,
          textSize: 20,
          isTitle: true,
          // isTitle: true,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '\$2.50',
          style: TextStyle(
            fontSize: 18,
            color: color,
            decoration: TextDecoration.lineThrough,
          ),
        )
      ]),
    );
  }
}
