import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_json/datamodel/restaurant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:search_page/search_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late List<Restaurant> restaurants;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Restaurant App'),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 40.0,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage(
                    barTheme: ThemeData(
                        appBarTheme: AppBarTheme(
                            backgroundColor: Theme.of(context).primaryColor)),
                    items: restaurants,
                    searchLabel: 'Cari Restoran',
                    suggestion: const Center(
                      child: Text(
                          'Mencari Restoran berdasarkan nama tempat dan lokasi'),
                    ),
                    failure: const Center(
                      child: Text('Hasil Tidak Ditemukan'),
                    ),
                    filter: (resto) => [
                      resto.name,
                      resto.city,
                    ],
                    builder: (resto) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/detailresto',
                            arguments: resto);
                      },
                      child: ListTile(
                        title: Text(resto.name),
                        subtitle: Text('${resto.city}, Indonesia'),
                        trailing: Text('rate ${resto.rating}'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasError) {
                return const Text('Error saat Memuat data....');
              } else {
                final List<Restaurant> restaurantList =
                    parseRestaurants(snapshot.data);
                restaurants = restaurantList;
                return ListView.builder(
                  itemCount: restaurantList.length,
                  itemBuilder: (context, index) {
                    return _buildCardRestaurant(context, restaurantList[index]);
                  },
                );
              }
            } else {
              return const Text('Sedang Memuat data....');
            }
          },
        ),
      ),
    );
  }

  Widget _buildCardRestaurant(BuildContext context, Restaurant restaurant) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 130,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, spreadRadius: 2),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(restaurant.pictureId),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        child: Text(
                          restaurant.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: restaurant.rating,
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 20.0,
                        ),
                        onRatingUpdate: (rating) {
                          null;
                        },
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
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/detailresto',
                              arguments: restaurant);
                        },
                        child: const Text('Selengkapnya...'),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
