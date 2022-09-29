import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_json/datamodel/restaurant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailResto extends StatelessWidget {
  final Restaurant restaurant;
  const DetailResto({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    pinned: false,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.fitWidth,
                      ),
                      title: Text(restaurant.name),
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    ),
                  ),
                ];
              },
              body: ListView(
                children: <Widget>[
                  buildBoys(),
                ],
              ))),
    );
  }

  Widget buildBoys() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Rating',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 8,
              ),
              RatingBar.builder(
                initialRating: restaurant.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
                onRatingUpdate: (rating) {
                  null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Lokasi',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.place,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  Text('${restaurant.city}, Indonesia'),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Deskripsi Tempat',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 8,
              ),
              Text(
                restaurant.description,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Makanan',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: restaurant.menus.foods
                      .map((food) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 140, 3, 3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    food,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Minuman :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: restaurant.menus.drinks
                      .map((drink) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 140, 3, 3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    drink,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
