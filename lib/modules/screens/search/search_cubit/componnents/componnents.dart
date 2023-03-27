import 'package:flutter/material.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/models/search_model/search_model.dart';

Widget buildProductSearchItem(
  DataSearchProduct model,
  context,
  // Products? productsModel,
) {
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
                  model.image.toString(),
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
                  "${model.name}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price!.round()}',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        HomeLayoutCubit.get(context).changeFavourites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 18,
                        backgroundColor: HomeLayoutCubit.get(context)
                                    .myFavourite[model.id] ==
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
