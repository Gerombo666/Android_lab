
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sun_stickers/data/_data.dart';



part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedState.initial());

  void onCategoryTap(StickerCategory category){
    final List<StickerCategory> categories = state.categories.map((e) {
      if (e.type == category.type) {
        return e.copyWith(isSelected: true);
      } else {
        return e.copyWith(isSelected: false);
      }
    }).toList();
    if (category.type == StickerType.all) {
      emit(state.copyWith(categories: categories, stickersByCategory: state.stickers));
    } else {
      final List<Sticker> stickersByCategory = state.stickers
          .where((e) => e.type == category.type)
          .toList();
      emit(state.copyWith(categories: categories, stickersByCategory: stickersByCategory));
    }
  }


  void onIncreaseQuantityTap(int stickerId) {
    final List<Sticker> stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      } else {
        return e;
      }
    }).toList();
    emit(state.copyWith(stickers: stickers));
  }

  void onDecreaseQuantityTap(int stickerId) {
    final List<Sticker> stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      } else {
        return e;
      }
    }).toList();
    emit(state.copyWith(stickers: stickers));
  }

  void onAddToCartTap(int stickerId){
    final List<Sticker> stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: true);
      } else {
        return e;
      }
    }).toList();
    emit(state.copyWith(stickers: stickers));
  }

  void onRemoveFromCartTap(int stickerId){
    final List<Sticker> stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      } else {
        return e;
      }
    }).toList();
    emit(state.copyWith(stickers: stickers));
  }

  void onCheckOutTap() {
    List<Sticker> stickers = <Sticker>[];
    Set<int> cartIds = <int>{};
    for (var item in cart) {
      cartIds.add(item.id);
    }
    stickers = state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      } else {
        return e;
      }
    }).toList();
    emit(state.copyWith(stickers: stickers));
  }

  void onAddRemoveFavoriteTap(int stickerId){
    final List<Sticker> stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(favorite: !e.favorite);
      } else {
        return e;
      }
    }).toList();
    emit(state.copyWith(stickers: stickers));
  }

  void onToggleThemeTab(){
    emit(state.copyWith(isLight: !state.isLight));
  }


  List<Sticker> get cart => state.stickers.where((e) => e.cart).toList();
  List<Sticker> get favorite => state.stickers.where((e) => e.favorite).toList();
  int getIndex(int stickerId) {
    int index = state.stickers.indexWhere((e) => e.id == stickerId);
    return index;
  }
  Sticker getStickerById(int stickerId) {
    return state.stickers[getIndex(stickerId)];
  }

  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }

  double get subtotal {
    double amount = 0.0;
    for (var e in cart) {
      amount = amount + e.price * e.quantity;
    }
    return amount;
  }
}