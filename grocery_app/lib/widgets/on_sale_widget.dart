import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/heat_btm.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';
import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../provider/cart_provider.dart';
import '../provider/wishlist_provider.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // final theme = Utils(context).getTheme;
    Size size = Utils(context).getsize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);    
    bool? _isInCart = cartProvider.getCardItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(productModel.id);        

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            // GlobalMethod.navigateTo(ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.height * 0.14,
                      width: size.width * 0.20,
                      boxFit: BoxFit.fitWidth,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: "1KG",
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartProvider.addProductToCart(
                                  productId: productModel.id,
                                  quantity: 1,
                                );
                              },
                              child: Icon(
                                _isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 20,
                                color: _isInCart? Colors.green :color,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child:  HeartBtn(
                                productId: productModel.id,
                                isInWishlist: _isInWishlist,
                              )
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                PriceWidget(
                  isOnSale: true,
                  price: productModel.price,
                  salePrice: productModel.salePrice,
                  textPrice: '2',
                ),
                const SizedBox(height: 5),
                TextWidget(
                  text: productModel.title,
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
