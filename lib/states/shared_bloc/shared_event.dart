part of 'shared_bloc.dart';

abstract class SharedEvent{}

class  CategoryTapEvent extends SharedEvent{
  CategoryTapEvent(this.category);
  final StickerCategory category;
}

class  SetSelectedStickerEvent extends SharedEvent{
  SetSelectedStickerEvent(this.stickerId);
  final int stickerId;
}

class  IncreaseQuantityTapEvent extends SharedEvent{
  IncreaseQuantityTapEvent(this.stickerId);
  final int stickerId;
}

class  DecreaseQuantityTapEvent extends SharedEvent{
  DecreaseQuantityTapEvent(this.stickerId);
  final int stickerId;
}

class  AddToCartTapEvent extends SharedEvent{
  AddToCartTapEvent(this.stickerId);
  final int stickerId;
}

class  RemoveFromCartTapEvent extends SharedEvent{
  RemoveFromCartTapEvent(this.stickerId);
  final int stickerId;
}

class CheckOutTapEvent extends SharedEvent {}

class AddRemoveFavoriteTapEvent extends SharedEvent{
  AddRemoveFavoriteTapEvent(this.stikerId);
  final int stikerId;
}


class ToggleThemeTabEvent extends SharedEvent{}