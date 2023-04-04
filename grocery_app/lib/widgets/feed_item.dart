import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/widgets/heat_btm.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';
import '../models/products_model.dart';
import '../provider/wishlist_provider.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getsize;
    final Color color = Utils(context).color;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCardItems.containsKey(productsModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(productsModel.id);

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productsModel.id);
            // GlobalMethod.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productsModel.imageUrl,
                height: size.height * 0.12,
                width: size.width * 0.14,
                boxFit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productsModel.title,
                        color: color,
                        maxLines: 1,
                        textSize: 18,
                        // isTitle: true,
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {},
                        child:  HeartBtn(
                          productId: productsModel.id,
                          isInWishlist: _isInWishlist,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: PriceWidget(
                        isOnSale: productsModel.isOnSale,
                        price: productsModel.price,
                        salePrice: productsModel.salePrice,
                        textPrice: _quantityTextController.text,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: FittedBox(
                              child: TextWidget(
                                text: productsModel.isPiece ? "Piece" : "KG",
                                color: color,
                                textSize: 18,
                                isTitle: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: _quantityTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(
                                color: color,
                                fontSize: 18,
                              ),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              textAlign: TextAlign.center,
                              onChanged: (valuee) {
                                setState(() {
                                  if (valuee.isEmpty) {
                                    // _quantityTextController.text = '1';//my changes
                                  }
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _isInCart
                      ? null
                      : () {
                          cartProvider.addProductToCart(
                              productId: productsModel.id,
                              quantity:
                                  int.parse(_quantityTextController.text));
                        },
                  child: TextWidget(
                    text: _isInCart ? "In Cart" : 'Add to cart',
                    maxLines: 1,
                    color: color,
                    textSize: 20,
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
