import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/_data.dart';
import '../../states/sticker_state.dart';
import '../../ui_kit/_ui_kit.dart';
import '../_ui.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Builder(
        builder: (context) {
          final favoriteItems = context.select((StickerState state) => state.favorite);
          return EmptyWrapper(
            type: EmptyWrapperType.favorite,
            title: "Empty favorite",
            isEmpty: favoriteItems.isEmpty,
            child: _favoriteListView(context),
          );
        }
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Favorite screen",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _favoriteListView(BuildContext context) {
    final favoriteItems = context.select((StickerState state) => state.favorite);
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: favoriteItems.length,
      itemBuilder: (_, index) {
        Sticker sticker = favoriteItems[index];
        return Card(
          color: Theme.of(context).brightness == Brightness.light ? Colors.white : AppColor.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              sticker.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Image.asset(sticker.image),
            subtitle: Text(
              sticker.description,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Icon(AppIcon.heart, color: Colors.redAccent),
          ),
        );
      },
      separatorBuilder: (_, __) => Container(
        height: 20,
      ),
    );
  }
}
