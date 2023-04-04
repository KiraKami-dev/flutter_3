import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/widgets/heat_btm.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/wishlist_provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityController = TextEditingController();
  @override
  void dispose() {
    _quantityController.text;
    super.dispose();
  }

  @override
  void initState() {
    _quantityController.text = '1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // final theme = Utils(context).getTheme;
    Size size = Utils(context).getsize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentprod = productsProvider.findProdById(productId);
    double usedPrice = getCurrentprod.isOnSale
        ? getCurrentprod.salePrice
        : getCurrentprod.price;
    double totalPrice = usedPrice * int.parse(_quantityController.text);
    bool? _isInCart = cartProvider.getCardItems.containsKey(getCurrentprod.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(getCurrentprod.id);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              Navigator.canPop(context) ? Navigator.pop(context) : null,
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: getCurrentprod.imageUrl,
              // height: size.width,
              width: size.width,
              boxFit: BoxFit.scaleDown,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: getCurrentprod.title,
                            color: color,
                            textSize: 22,
                            isTitle: true,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: HeartBtn(
                            productId: getCurrentprod.id,
                          isInWishlist: _isInWishlist,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 30,
                      right: 30,
                    ),
                    child: Row(children: [
                      TextWidget(
                        text: "\$${usedPrice.toStringAsFixed(2)}",
                        color: color,
                        textSize: 22,
                      ),
                      TextWidget(
                        text: getCurrentprod.isPiece ? "/piece" : "/Kg",
                        color: color,
                        textSize: 12,
                        isTitle: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: getCurrentprod.isOnSale ? true : false,
                        child: Text(
                          '\$${getCurrentprod.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 15,
                            color: color,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(63, 200, 101, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextWidget(
                          text: 'Free delivery',
                          color: Colors.white,
                          textSize: 20,
                          isTitle: true,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      quantityController(
                        fct: () {
                          setState(() {
                            if (_quantityController.text == '1') {
                              return;
                            } else {
                              _quantityController.text =
                                  (int.parse(_quantityController.text) - 1)
                                      .toString();
                            }
                          });
                        },
                        color: Colors.red,
                        icon: CupertinoIcons.minus,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
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
                      const SizedBox(
                        width: 5,
                      ),
                      quantityController(
                          fct: () {
                            setState(() {
                              _quantityController.text =
                                  (int.parse(_quantityController.text) + 1)
                                      .toString();
                            });
                          },
                          color: Colors.green,
                          icon: CupertinoIcons.add),
                    ], // mainAxisAlignment: Material,
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Total',
                                    color: color,
                                    textSize: 20,
                                    isTitle: true,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    child: Row(children: [
                                      TextWidget(
                                        text:
                                            '\$${totalPrice.toStringAsFixed(2)}/',
                                        color: color,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                        text: '${_quantityController.text}Kg',
                                        color: color,
                                        textSize: 16,
                                        isTitle: false,
                                      ),
                                    ]),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: _isInCart
                                  ? null
                                  : () {
                                      cartProvider.addProductToCart(
                                          productId: getCurrentprod.id,
                                          quantity: int.parse(
                                              _quantityController.text));
                                    },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                      text: _isInCart ? "In Cart" : 'Add to cart',
                                      color: Colors.white,
                                      textSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityController({
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
