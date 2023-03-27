import 'package:flutter/material.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';

Widget buildFavouriteItem(model, context) {
  return Padding(
    padding: const EdgeInsets.all(
      20,
    ),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                width: 120,
                height: 120,
                image: NetworkImage(
                  model.product!.image.toString(),
                ),
              ),
              if (model.product!.discount! > 0)
                Container(
                  color: Colors.red,
                  child: const Text(
                    "DISCOUNT",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.product!.name}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    if (model.product!.discount! > 0)
                      Text(
                        '${model.product!.oldPrice!.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.product!.price!.round()}',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        HomeLayoutCubit.get(context)
                            .changeFavourites(model.product!.id);
                      },
                      icon: CircleAvatar(
                        radius: 18,
                        backgroundColor: HomeLayoutCubit.get(context)
                                    .myFavourite[model.product!.id] ==
                                true
                            ? Colors.blue
                            : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
