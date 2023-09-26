import 'package:flutter/material.dart';

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
  Future<void> onCategoryTap(StickerCategory tapedCategory) async {
    categories.map((category) {
      if (category.type == tapedCategory.type) {
        category.isSelected = true;
      } else {
        category.isSelected = false;
      }
    }).toList();

    if (tapedCategory.type == StickerType.all) {
      stickersByCategory = stickers;
    } else {
      stickersByCategory = stickers.where((category) =>
      category.type == tapedCategory.type).toList();
    }
  }

  Future<void> onIncreaseQuantityTap(Sticker sticker) async {
    sticker.quantity++;
  }

  Future<void> onDecreaseQuantityTap(Sticker sticker) async {
    if (sticker.quantity == 1) return;
    sticker.quantity--;
  }

  Future<void> onAddToCartTap(Sticker sticker) async {
    debugPrint('Добавляем стикер в корзину');
    sticker.cart = true;
    cartKey.currentState?.update();
  }

  Future<void> onRemoveFromCartTap(Sticker sticker) async {}

  Future<void> onCheckOutTap() async {}

  Future<void> onAddRemoveFavoriteTap(Sticker sticker) async{}

  void toggleTheme() {}


//Вспомогательные  методы
  //String stickerPrice(Sticker sticker) {}

  //double get subtotal {}





}
