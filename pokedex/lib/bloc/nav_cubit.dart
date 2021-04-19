import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_details_cubit.dart';

class NavCubit extends Cubit<int> {
  PokemonDetailsCubit pokemonDetailsCubit;

  NavCubit({this.pokemonDetailsCubit}) : super(null);

  void showPokemonDetails(int pokemonID) {
    print(pokemonID);
    pokemonDetailsCubit.getPokemonDetails(pokemonID);
    emit(pokemonID);
  }

  void popToPokedex() {
    emit(null);
    pokemonDetailsCubit.clearPokemonDetails();
  }
}
