import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/_data.dart';
import '../../states/sticker_state.dart';
import '../../ui_kit/_ui_kit.dart';
import '../widgets/_widgets.dart';

class StickerDetail extends StatefulWidget {
  const StickerDetail({super.key, required this.sticker});
  final Sticker sticker;


  @override
  State<StickerDetail> createState() => StickerDetailState();
}

class StickerDetailState extends State<StickerDetail> {
  late final sticker = widget.sticker;

  bool isOpenCart = false;

  //Todo: Favorite добавление и удаление
  /*
  //int get stickerId => StickerState().selectedStickerId;
  //Sticker get sticker => StickerState().stickerById(stickerId);

  int get stickerId => StickerState().selectedStickerId;
  Sticker get sticker =>
      StickerState().stickerById(stickerId);
  late int _quantity = sticker.quantity;
  */

  void onIncreaseQuantityTap() async {
    print('Увеличить количество');
    await StickerState().onIncreaseQuantityTap(sticker);
    setState(() {});
  }

  void onDecreaseQuantityTap() async {
    print('Уменьшить количество');
    await StickerState().onDecreaseQuantityTap(sticker);
    setState(() {});
  }

  //Todo: Favorite добавление и удаление
  /*
  void onAddDeleteFavoriteTap() async {
    await
    StickerState().onAddDeleteFavoriteTap(stickerId);
    setState(() {});
  }
  */

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sticker added to cart'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const[
                Text('Do you want open cart?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style:TextStyle(color:AppColor.accent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style:TextStyle(color: AppColor.accent),),
              onPressed: () {
                isOpenCart = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onAddToCartTap() async {
    await StickerState().onAddToCartTap(sticker);
    await _showDialog();
    if (isOpenCart) {
      isOpenCart = false;

  }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(child: Image.asset(sticker.image, scale: 2)),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _bottomAppBar(),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        'Sticker Detail Screen',
        style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      elevation: 0.0,
      backgroundColor: AppColor.accent,
      onPressed: () {},
      child: sticker.isFavorite ? const Icon(AppIcon.heart) : const Icon(AppIcon.outlinedHeart),
    );
  }

  Widget _bottomAppBar() {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomAppBar(
            child: SizedBox(
                height: 300,
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark ? AppColor.dark : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                itemPadding: EdgeInsets.zero,
                                itemSize: 20,
                                initialRating: sticker.score,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                glow: false,
                                ignoreGestures: true,
                                itemBuilder: (_, __) => const FaIcon(
                                  FontAwesomeIcons.solidStar,
                                  color: AppColor.yellow,
                                ),
                                onRatingUpdate: (rating) {
                                  print('$rating');
                                },
                              ),
                              const SizedBox(width: 15),
                              Text(
                                sticker.score.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "(${sticker.voter})",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${sticker.price}",
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColor.accent),
                              ),
                              CounterButton(
                                onIncrementTap: onIncreaseQuantityTap,
                                onDecrementTap: onDecreaseQuantityTap,
                                label: Text(
                                  sticker.quantity.toString(),
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            sticker.description,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: ElevatedButton(
                                onPressed:  () => StickerState().onAddToCartTap(sticker),
                                child: const Text("Add to cart"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
