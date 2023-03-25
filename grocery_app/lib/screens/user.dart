import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/view_recently/viewed_recently.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Hi, ',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'KiraKami',
                          style: TextStyle(
                            color: color,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('My name is pressed');
                            }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextWidget(
                    text: 'Kira@gmail.com',
                    color: color,
                    textSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                _listTiles(
                  icon: IconlyBold.profile,
                  titleText: "Address",
                  subtitle: "yo",
                  color: color,
                  onPressed: () {
                    _showAddressDialog();
                  },
                ),
                _listTiles(
                    icon: IconlyBold.addUser,
                    titleText: "Orders",
                    color: color,
                    onPressed: () {
                      GlobalMethod.navigateTo(
                          ctx: context, routeName: OrdersScreen.routeName);
                    }),
                _listTiles(
                    icon: IconlyBold.bag,
                    titleText: "Wishlist",
                    color: color,
                    onPressed: () {
                      GlobalMethod.navigateTo(
                        ctx: context,
                        routeName: WishListScreen.routeName,
                      );
                    }),
                _listTiles(
                    icon: IconlyBold.heart,
                    titleText: "Viewed",
                    color: color,
                    onPressed: () {
                      GlobalMethod.navigateTo(
                          ctx: context,
                          routeName: ViewedRecentlyScreen.routeName);
                    }),
                _listTiles(
                    icon: IconlyBold.show,
                    titleText: "Forget Password",
                    color: color,
                    onPressed: () {}),
                SwitchListTile(
                  title: TextWidget(
                    text: "Theme",
                    color: color,
                    textSize: 18,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    setState(
                      () {
                        themeState.setDarkTheme = value;
                      },
                    );
                  },
                  value: themeState.getDarkTheme,
                ),
                _listTiles(
                  icon: IconlyBold.unlock,
                  titleText: "Logout",
                  color: color,
                  onPressed: () {
                    GlobalMethod.warningDialog(
                        title: "Sign out",
                        subtitle: 'are you sure?',
                        ftc: () {},
                        context: context,
                        imgadd: "images/logout.png");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Address"),
          content: TextField(
            onChanged: (value) async {
              // ignore: avoid_print
              print(
                  '_addressTextController.text ${_addressTextController.text}');
            },
            controller: _addressTextController,
            maxLines: 5,
            decoration: const InputDecoration(hintText: "Your address"),
          ),
          actions: [TextButton(onPressed: () {}, child: const Text("Update"))],
        );
      },
    );
  }

  Widget _listTiles(
      {required IconData icon,
      required String titleText,
      String? subtitle,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(text: titleText, color: color, textSize: 22),
      // ignore: prefer_if_null_operators
      subtitle: TextWidget(
          text: subtitle == null ? "" : subtitle, color: color, textSize: 18),
      // subtitle: Text(),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
