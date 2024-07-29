import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_model.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(
          pokemon.name.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
      ),

      body: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,

            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,

            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 60),

                  Text(
                    pokemon.name.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900
                    ),
                  ),

                  Text(
                    'Height: ${pokemon.height}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  Text(
                    'Weight: ${pokemon.weight}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  customHeading("Types"),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type!.map(
                      (type) => customContainer(type, Colors.amber, color: Colors.black)
                    ).toList(),
                  ),

                  customHeading('Weakness'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses!.length <= 5 ?
                    pokemon.weaknesses!.map(
                      (weakness) => customContainer(weakness, Colors.red)
                    ).toList() :
                    [
                      customContainer(pokemon.weaknesses![0], Colors.red),
                      customContainer(pokemon.weaknesses![1], Colors.red),
                      customContainer(pokemon.weaknesses![2], Colors.red),
                      customContainer(pokemon.weaknesses![3], Colors.red),
                      customContainer(pokemon.weaknesses![4], Colors.red),
                    ]
                    ,
                  ),

                  customHeading('Next Evolution'),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution == null ?
                        <Widget> [
                          const Text(
                            "This is the final form",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ] :
                        pokemon.nextEvolution!.map(
                            (evo) => customContainer(
                              evo.name.toString(),
                              Colors.green
                            )
                    ).toList(),
                  ),
                ],
              ),
            )
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img.toString(),
              child:Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pokemon.img.toString())
                  )
                ),
              ),
            ),
          )
        ],
      ),

      backgroundColor: Colors.cyan,
    );
  }

  Text customHeading(String data) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
      )
    );
  }

  Container customContainer(String text, Color bgColor, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 13.0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: color ?? Colors.white
        )
      ),
    );
  }
}
