import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/widgets/heat_btm.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../provider/wishlist_provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityController = TextEditingController();
  @override
  void initState() {
    _quantityController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // final theme = Utils(context).getTheme;
    Size size = Utils(context).getsize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentprod = productsProvider.findProdById(cartModel.productId);
    double usedPrice = getCurrentprod.isOnSale
        ? getCurrentprod.salePrice
        : getCurrentprod.price;
    double totalPrice = usedPrice * int.parse(_quantityController.text);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentprod.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productId);
      },
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FancyShimmerImage(
                    imageUrl: getCurrentprod.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: getCurrentprod.title,
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      child: Row(
                        children: [
                          _quantitycontroller(
                              fct: () {
                                if (_quantityController.text == '1') {
                                  return;
                                } else {
                                  cartProvider
                                      .reduceQuantityByOne(cartModel.productId);
                                  setState(() {
                                    _quantityController.text =
                                        (int.parse(_quantityController.text) -
                                                1)
                                            .toString();
                                  });
                                }
                              },
                              color: Colors.red,
                              icon: CupertinoIcons.minus),
                          Flexible(
                            child: TextField(
                              controller: _quantityController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                ),
                              ],
                              onChanged: (valuee) {
                                setState(() {
                                  if (valuee.isEmpty) {
                                    _quantityController.text = '1';
                                  } else {
                                    return;
                                  }
                                });
                              },
                            ),
                          ),
                          _quantitycontroller(
                              fct: () {
                                cartProvider
                                    .increaseQuantityByOne(cartModel.productId);
                                setState(() {
                                  _quantityController.text =
                                      (int.parse(_quantityController.text) + 1)
                                          .toString();
                                });
                              },
                              color: Colors.green,
                              icon: CupertinoIcons.add),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          cartProvider.removeOneItem(cartModel.productId);
                        },
                        child: const Icon(
                          CupertinoIcons.cart_badge_minus,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {},
                        child: HeartBtn(
                            productId: getCurrentprod.id,
                            isInWishlist: _isInWishlist),
                      ),
                      TextWidget(
                        text: '\$${usedPrice.toStringAsFixed(2)}',
                        color: color,
                        textSize: 18,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ))
      ]),
    );
  }

  Widget _quantitycontroller({
    required Function fct,
    required Color color,
    required IconData icon,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
              onTap: () {
                fct();
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ),
      ),
    );
  }
}
