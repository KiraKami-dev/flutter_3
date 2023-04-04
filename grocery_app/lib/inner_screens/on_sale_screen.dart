import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/empty_prod.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/products_provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScrenn";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getsize;
    final productsProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productOnSale = productsProviders.getOnSaleProduct;
        
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
      body: productOnSale.isEmpty
          // ignore: dead_code
          ? const EmptyProductWidget(text: "No Product on Sale",)
          : GridView.count(
              crossAxisCount: 2,
              // shrinkWrap: true,
              padding: EdgeInsets.zero,
              // physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / (size.height * 0.60),
              children: List.generate(
                productOnSale.length,
                (index) {
                  return ChangeNotifierProvider.value(
                    value: productOnSale[index],
                    child: const OnSaleWidget(),
                  );
                },
              ),
            ),
    );
  }
}
