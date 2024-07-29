import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/screen/pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PokeHub? pokeHub;

  fetchData() async {
    var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    final respond = await http.get(Uri.parse(url));
    if (respond.statusCode == 200) {
      var data = jsonDecode(respond.body.toString());
      pokeHub = PokeHub.fromJson(data);
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text(
          "Pokemon",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
      ),

      body: Center(
        child:
          pokeHub == null ?
          const CircularProgressIndicator() :
          GridView.count(
            crossAxisCount: 2,
            children: pokeHub!.pokemon!.map(
                  (poke) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PokemonDetailScreen(pokemon: poke))
                      );
                    },
                    child: Hero(
                      tag: poke.img.toString(),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(poke.img.toString())
                                )
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                poke.name.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              )).toList(),
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            fetchData();
          });
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.refresh_sharp),
      ),
    );
  }
}
