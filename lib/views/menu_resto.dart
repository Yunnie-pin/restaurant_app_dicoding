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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width) * 1 / 2,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: Center(
                            child: Text(
                              restaurant.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: RatingBar.builder(
                          initialRating: restaurant.rating,
                          itemSize: 20,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 20.0,
                          ),
                          onRatingUpdate: (rating) {
                            null;
                          },
                        ),
                      ),
                      Center(
                        child: Text('${restaurant.city}, Indonesia',
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).primaryColor)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/detailresto',
                                arguments: restaurant);
                          },
                          child: const Text('Selengkapnya...'),
                        ),
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
