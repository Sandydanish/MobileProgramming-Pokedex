import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/pokedata/pokemon_info_page.dart';
import 'package:pokedex/pokedata/pokemon_page.dart';
import 'package:pokedex/pokedata/pokemon_species_info.dart';

class PokemonRepo {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    final queryParameters = {
      'limit': '151',
      'offset': (pageIndex * 151).toString()
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.fromJson(json);
  }

  Future<PokemonInfoResponse> getPokemonInfo(int pokemonID) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonID');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponse.fromJson(json);
    } catch (e) {
      print(e);
    }
  }

  Future<PokemonSpeciesInfo> getPokemonSpeciesInfo(int pokemonID) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonID');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonSpeciesInfo.fromJson(json);
    } catch (e) {
      print(e);
    }
  }
}
