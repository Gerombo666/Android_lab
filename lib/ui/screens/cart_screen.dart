import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sun_stickers/states/sticker_state.dart';

import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';
import '../_ui.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  double taxes = 5.0;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cartItems = context.select((StickerState state) => state.cart);
        return Scaffold(
          appBar: _appBar(context),
          body: EmptyWrapper(
            title: "Empty cart",
            isEmpty: cartItems.isEmpty,
            child: _cartListView(context),
          ),
          bottomNavigationBar: cartItems.isEmpty? const SizedBox.shrink() : _bottomAppBar(context),
        );
      }
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Cart screen",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _cartListView(BuildContext context) {
    final cartItems = context.select((StickerState state) => state.cart);
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: cartItems.length,
      itemBuilder: (_, index) {
        final sticker = cartItems[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              print('Удаляем');
              context.read<StickerState>().onRemoveFromCartTap(sticker.id);
            }
          },
          key: UniqueKey(),
          background: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const FaIcon(FontAwesomeIcons.trash),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).brightness == Brightness.dark ? AppColor.dark : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 20),
                Image.asset(sticker.image, scale: 10),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sticker.name,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "\$${sticker.price}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    CounterButton(
                      onIncrementTap: () => context.read<StickerState>().onIncreaseQuantityTap(sticker.id),
                      onDecrementTap: () => context.read<StickerState>().onDecreaseQuantityTap(sticker.id),
                      size: const Size(24, 24),
                      padding: 0,
                      label: Text(
                        sticker.quantity.toString(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Text(
                      "\$${context.read<StickerState>().stickerPrice(sticker)}",
                      style: AppTextStyle.h2Style.copyWith(color: AppColor.accent),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => Container(
        height: 20,
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomAppBar(
          child: SizedBox(
              height: 250,
              child: Container(
                color: Theme.of(context).brightness == Brightness.dark ? AppColor.dark : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                "\$${context.read<StickerState>().subtotal}",
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Taxes",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                "\$${taxes}",
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(thickness: 4.0, height: 30.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                "\$${context.read<StickerState>().subtotal + taxes}",
                                style: AppTextStyle.h2Style.copyWith(
                                  color: AppColor.accent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: ElevatedButton(
                              onPressed: () => context.read<StickerState>().onCheckOutTap(),
                              child: const Text("Checkout"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}
