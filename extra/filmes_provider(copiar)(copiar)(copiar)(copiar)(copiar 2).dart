import 'dart:async';
import 'dart:convert';

import 'package:filmes/src/models/actores_model.dart';
import 'package:filmes/src/models/filmes_model.dart';

import 'package:http/http.dart' as http;

class FilmesProvider {
  String _apikey = 'f50f2a9733f4a09c546a75bd6a80e915';
  String _url = 'api.themoviedb.org';
  String _language = 'pt-PT';

  int _popularesPage = 0;
  bool _carregando = false;

  List<Filme> _populares = new List();

//inicio Stream
  final _popularesStreamController = StreamController<List<Filme>>.broadcast();

  Function(List<Filme>) get popularesSink =>
      _popularesStreamController.sink.add; //entrada

  Stream<List<Filme>> get popularesStream =>
      _popularesStreamController.stream; //saida

//para destruir o stream
  void disposeStream() {
    _popularesStreamController?.close();
  }

  //fim de estream

  Future<List<Filme>> getEnCine() async {
    final url = Uri.http(
      _url,
      '3/movie/now_playing',
      {'api_key': _apikey, 'language': _language},
    );

    return await _processarResposta(url);
  }

  Future<List<Filme>> getPopulares() async {
    if (_carregando) return []; //se esta carregando dados para

    _carregando = true;
    _popularesPage++;

    final url = Uri.https(
      _url,
      '3/movie/popular',
      {
        'api_key': _apikey,
        'language': _language,
        'page': _popularesPage.toString()
      },
    );

    final resp = await _processarResposta(url);
    _populares.addAll(resp);

    popularesSink(_populares);
    _carregando = false;
    return resp;
  }

  ///r
  Future<List<Filme>> _processarResposta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final filmes = new Filmes.fromJsonList(decodeData['results']);
    return filmes.items;
  }

  Future<List<Actor>> getCast(String filmeID) async {
    final url = Uri.https(_url, '3/movie/$filmeID/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Filme>> busarFilme(String query) async {
    final url = Uri.https(
      _url,
      '3/search/movie',
      {'api_key': _apikey, 'language': _language, 'query': query},
    );



    return await _processarResposta(url);
  }
}
