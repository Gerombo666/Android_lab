part of 'shared_bloc.dart';

class SharedState extends Equatable {
  SharedState({
    required this.categories,
    required this.stickers,
    required this.stickersByCategory,
    required this.isLight,
  });

  List<StickerCategory> categories;
  List<Sticker> stickers;
  List<Sticker> stickersByCategory;
  bool isLight;

  SharedState.initial() : this(
    categories: AppData.categories,
    stickers: AppData.stickers,
    stickersByCategory: AppData.stickers,
    isLight: true,
  );

  @override
  List<Object?> get props =>
      [categories, stickers, stickersByCategory, isLight];

  SharedState copyWith({
    List<StickerCategory>? categories,
    List<Sticker>? stickers,
    List<Sticker>? stickersByCategory,
    bool? isLight,
  }) {
    return SharedState(
      categories: categories ?? this.categories,
      stickers: stickers ?? this.stickers,
      stickersByCategory: stickersByCategory ?? this.stickersByCategory,
      isLight: isLight ?? this.isLight,
    );
  }
}