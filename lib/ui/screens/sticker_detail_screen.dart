import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sun_stickers/states/_states.dart';

import '../../data/_data.dart';
import '../../states/shared_cubit/shared_cubit.dart';
import '../../ui_kit/_ui_kit.dart';
import '../widgets/_widgets.dart';

class StickerDetail extends StatelessWidget {
  StickerDetail({super.key, required this.sticker});
  final Sticker sticker;

  @override
  Widget build(BuildContext context) {
    debugPrint('StickerDetail >> Перерисовка экрана деталей');
    return Scaffold(
      appBar: _appBar(context),
      body: Center(child: Image.asset(sticker.image, scale: 2)),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _bottomAppBar(context),
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

  Widget _floatingActionButton(BuildContext context) {
    debugPrint('StickerDetail >> Перерисовка экрана деталей');
    return Builder(
      builder: (context) {
        final favorite = context.select((SharedCubit b) => b.getStickerById(sticker.id).favorite);
        return FloatingActionButton(
          elevation: 0.0,
          backgroundColor: AppColor.accent,
          onPressed: () => context.read<SharedCubit>().onAddRemoveFavoriteTap(sticker.id),
          child: favorite ? const Icon(AppIcon.heart) : const Icon(AppIcon.outlinedHeart),
        );
      }
    );
  }

  Widget _bottomAppBar(BuildContext context) {
    debugPrint('StickerDetail >> Перерисовка экрана деталей: _bottomAppBar');
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
                                onIncrementTap: () => context.read<SharedCubit>().onIncreaseQuantityTap(sticker.id),
                                onDecrementTap: () => context.read<SharedCubit>().onDecreaseQuantityTap(sticker.id),
                                label: Builder(
                                  builder: (context) {
                                    //final bloc = context.watch<SharedBloc>();
                                    //final quantity = context.watch<SharedBloc>().getStickerById(sticker.id).quantity;
                                    final quantity = context.select((SharedCubit b) => b.getStickerById(sticker.id).quantity);
                                    debugPrint('StickerDetail >> Управление количеством');
                                    return Text(
                                      quantity.toString(),
                                      style: Theme.of(context).textTheme.displayLarge,
                                    );
                                  }
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
                                onPressed: () => context.read<SharedCubit>().onAddToCartTap(sticker.id),
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
