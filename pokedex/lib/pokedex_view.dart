import 'package:pokedex/bloc/nav_cubit.dart';
import 'package:pokedex/bloc/pokemon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedata/pokemon_page.dart';
import 'bloc/pokemon_state.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P@KEDEX'),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.pokemonListing.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<NavCubit>(context)
                      .showPokemonDetails(state.pokemonListing[index].id),
                  child: Card(
                    color: Colors.green,
                    child: GridTile(
                      child: Column(
                        children: [
                          Image.network(state.pokemonListing[index].imageUrl),
                          Text(
                            state.pokemonListing[index].name,
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
