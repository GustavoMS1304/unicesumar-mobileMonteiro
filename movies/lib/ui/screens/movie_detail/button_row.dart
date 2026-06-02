import 'package:flutter/material.dart';

import 'package:movies/utils/utils.dart';
import 'package:movies/ui/widgets/text_icon.dart';

typedef OnFavoriteSelected = void Function();

class ButtonRow extends StatefulWidget {
  final bool favoriteSelected;
  final OnFavoriteSelected onFavoriteSelected;

  const ButtonRow({
    super.key,
    required this.favoriteSelected,
    required this.onFavoriteSelected,
  });

  @override
  State<ButtonRow> createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust pulse duration
    )..repeat(reverse: true); // Make animation repeat

    _sizeAnimation = Tween<double>(
      begin: 1.0, // Original size
      end: 1.5, // Scaled-up size
    ).animate(
      CurvedAnimation(parent: _sizeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 0, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextIcon(
            text: Text(
              'Favorite',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            icon: IconButton(
              onPressed: () {
                widget.onFavoriteSelected();
              },
              icon: widget.favoriteSelected
                  ? AnimatedBuilder(
                      animation: _sizeController,
                      builder: (context, child) {
                        return Icon(
                          Icons.favorite_outlined,
                          size: 21 * _sizeAnimation.value,
                          color: Colors.red,
                        );
                      })
                  : Icon(
                      Icons.favorite_border,
                      color: Theme.of(context).iconTheme.color,
                    ),
            ),
          ),
          addHorizontalSpace(32),
          TextIcon(
            text: Text(
              'Rate',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            icon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.thumb_up_alt_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          addHorizontalSpace(32),
          TextIcon(
            text: Text(
              'Share',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            icon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.ios_share,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
