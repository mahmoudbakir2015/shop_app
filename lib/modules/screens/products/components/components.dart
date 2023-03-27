import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';

Widget builderWidgets(
    HomeModel homeModel, CategoryModel categoryModel, context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCarouselSlider(homeModel),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Categories",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: categoryModel.data!.data!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 5,
              ),
              itemBuilder: (BuildContext context, int index) =>
                  buildCategoriesItem(
                categoryModel.data!.data![index],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "New Products",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          GridView.count(
            childAspectRatio: 1 / 1.69,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
              homeModel.data!.products!.length,
              (index) => buildGridProduct(
                  homeModel.data!.products![index], index, context),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCarouselSlider(HomeModel model) {
  return CarouselSlider(
    items: model.data!.banners
        ?.map(
          (e) => Image(
            width: double.infinity,
            fit: BoxFit.cover,
            image: NetworkImage(
              e.image.toString(),
            ),
          ),
        )
        .toList(),
    options: CarouselOptions(
      height: 200,
      initialPage: 0,
      enableInfiniteScroll: true,
      viewportFraction: 1.0,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(
        seconds: 3,
      ),
      autoPlayAnimationDuration: const Duration(
        seconds: 1,
      ),
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
      scrollDirection: Axis.horizontal,
    ),
  );
}

Widget buildGridProduct(Products model, int index, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(
            width: double.infinity,
            height: 200,
            image: NetworkImage(
              model.image.toString(),
            ),
          ),
          if (model.discount > 0)
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
      Text(
        model.name.toString(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          height: 1.3,
        ),
      ),
      Row(
        children: [
          if (model.discount > 0)
            Text(
              '${model.oldPrice?.round()}',
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
            '${model.price?.round()}',
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
              backgroundColor:
                  HomeLayoutCubit.get(context).myFavourite[model.id] == true
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
  );
}

Widget buildCategoriesItem(DataCategory dataCategory) {
  return SizedBox(
    width: 100,
    height: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          image: NetworkImage(
            dataCategory.image.toString(),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.black.withOpacity(
            0.8,
          ),
          child: Text(
            dataCategory.name.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
