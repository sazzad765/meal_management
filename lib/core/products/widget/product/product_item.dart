import 'package:bloc_example/common/widget/custom_button.dart';
import 'package:bloc_example/common/widget/custom_card.dart';
import 'package:bloc_example/common/widget/custom_image.dart';
import 'package:bloc_example/common/widget/extension/widget_extension.dart';
import 'package:bloc_example/common/utils/theme/custom_themes.dart';
import 'package:bloc_example/common/utils/theme/text_theme.dart';
import 'package:bloc_example/core/products/bloc/product_bloc.dart';
import 'package:bloc_example/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/common/utils/status.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
    this.onTap,
    this.onLongPress,
    this.onCart,
  }) : super(key: key);

  final Product product;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onCart;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocSelector<ProductBloc, ProductState, bool>(
      selector: (state) =>
          (state.status.isSelected && state.idSelected == product.id),
      builder: (context, state) {
        return CustomCard(
          onTap: onTap,
          onLongPress: onLongPress,
          borderWidth: state ? 1 : null,
          margin: const EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomImage(imageUrl: product.image ?? '', height: 150),
              CustomSpacing.verticalSpace(space: 8),
              Text(
                product.title ?? '',
                style: theme.textTheme.boldFont,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).horizontalPadding(16),
              CustomSpacing.verticalSpace(space: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  product.description ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomSpacing.verticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: 'Add to cart',
                    onPressed: onCart,
                  ).width(150).height(40),
                  Text(
                    '\$${product.price}',
                    style: theme.textTheme.titleSmall,
                  )
                ],
              ).padding(left: 16, right: 16, bottom: 16)
            ],
          ),
        );
      },
    );
  }
}
