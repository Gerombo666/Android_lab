import 'package:flutter/cupertino.dart';

import '../data/_data.dart';
import '../ui/_ui.dart';

class StickerState {
  StickerState._();
  static final _instance = StickerState._();
  factory StickerState() => _instance;



//Ключи
  GlobalKey<CartScreenState> cartKey = GlobalKey();
  GlobalKey<FavoriteScreenState> favoriteKey = GlobalKey();


//Переменные

  List<StickerCategory> categories = AppData.categories;
  List<Sticker> stickers = AppData.stickers;

  List<Sticker> stickersByCategory = AppData.stickers;
  List<Sticker> get cart => stickers.where((element) => element.cart).toList();
  List<Sticker> get favorite => stickers.where((element) => element.isFavorite).toList();
  ValueNotifier<bool> isLigth = ValueNotifier(true);


//Действия
  Future<void> onCategoryTap(StickerCategory category) async {
    categories.map((e) {
      if (e.type == category.type) {
        e.isSelected = true;
      } else {
        e.isSelected = false;
      }
    }).toList();
  }

  Future<void> onIncreaseQuantityTap(Sticker sticker) async {}

  Future<void> onDecreaseQuantityTap(Sticker sticker) async {}

  Future<void> onAddToCartTap(Sticker sticker) async {}

  Future<void> onRemoveFromCartTap(Sticker sticker) async {}

  Future<void> onCheckOutTap() async {}

  Future<void> onAddRemoveFavoriteTap(Sticker sticker) async{}

  void toggleTheme() {}


//Вспомогательные  методы
  //String stickerPrice(Sticker sticker) {}

  //double get subtotal {}





}
