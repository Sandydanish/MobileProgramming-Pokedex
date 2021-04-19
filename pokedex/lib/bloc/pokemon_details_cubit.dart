import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedata/pokemon_detail.dart';
import 'package:pokedex/pokedata/pokemon_info_page.dart';
import 'package:pokedex/pokedata/pokemon_repo.dart';
import 'package:pokedex/pokedata/pokemon_species_info.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  final _pokemonRepo = PokemonRepo();

  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int pokemonID) async {
    final response = await Future.wait([
      _pokemonRepo.getPokemonInfo(pokemonID),
      _pokemonRepo.getPokemonSpeciesInfo(pokemonID),
    ]);

    final pokemonInfo = response[0] as PokemonInfoResponse;
    final speciesInfo = response[1] as PokemonSpeciesInfo;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: pokemonInfo.imageUrl,
        types: pokemonInfo.types,
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: speciesInfo.description));
  }

  void clearPokemonDetails() => emit(null);
}
