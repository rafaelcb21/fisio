import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    await openDatabase(dbPath, version: 1, onCreate: this._create);
  }

  Future _create(Database db, int version) async {
    await db.execute(
      """
        CREATE TABLE formulario (
          id INTEGER PRIMARY KEY,
          nome TEXT NOT NULL,
          genero TEXT NOT NULL,
          idade INTEGER NOT NULL,
          peso REAL NOT NULL,
          altura INTEGER NOT NULL,
          endereco TEXT NOT NULL,
          pimax REAL NOT NULL,
          pemax REAL NOT NULL,
          pimaxnormal REAL NOT NULL,
          pemaxnormal REAL NOT NULL,
          versao INTEGER NOT NULL,
          repousofc INTEGER,
          repousofr INTEGER,
          repousospo INTEGER,
          repousopa INTEGER,
          repousobrogd INTEGER,
          repousommii INTEGER,
          repousooxigenio INTEGER,
          min3fc INTEGER,
          min3fr INTEGER,
          min3spo INTEGER,
          min3pa INTEGER,
          min3brogd INTEGER,
          min3mmii INTEGER,
          min3oxigenio INTEGER,
          min6fc INTEGER,
          min6fr INTEGER,
          min6spo INTEGER,
          min6pa INTEGER,
          min6brogd INTEGER,
          min6mmii INTEGER,
          min6oxigenio INTEGER,
          repouso2fc INTEGER,
          repouso2fr INTEGER,
          repouso2spo INTEGER,
          repouso2pa INTEGER,
          repouso2brogd INTEGER,
          repouso2mmii INTEGER,
          repouso2oxigenio INTEGER,
          distancia INTEGER NOT NULL,
          tc6min REAL NOT NULL,
          vo2pico REAL NOT NULL
        )
      """
    );

    await db.execute(
      """
        CREATE TABLE login (
          id INTEGER PRIMARY KEY,
          user TEXT NOT NULL,
          email TEXT NOT NULL
        )
      """
    );

  }
}

class BancoDados {
  
  Future getLogin() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    List results = await db.rawQuery("SELECT * FROM login");
    bool resposta = false;
    if(results.length > 0) { resposta = true; }
    await db.close();
    return resposta;
  }

  Future insertLogin(String user, String email) async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    await db.rawInsert("INSERT INTO login (user, email) VALUES (?, ?)", [user, email]);        
    await db.close();
    return true;
  }

  Future getFavorito(String uuid) async {
    bool favorito = false;
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    List results = await db.rawQuery("SELECT uuid, favorito FROM imovel WHERE uuid = ?", [uuid]);
    if(results[0]['favorito'] == "Não") {
      favorito = true;
    }
    await db.close();
    return favorito;
  }

  Future getAllFavorito() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    List results = await db.rawQuery("SELECT * FROM imovel WHERE favorito = 'Sim'");
    await db.close();
    return results;
  }

  Future updateFavorito(String uuid, String valor) async {
    bool favorito = false;
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    await db.rawUpdate("UPDATE imovel SET favorito = ? WHERE uuid = ?", [valor, uuid]);
    List results = await db.rawQuery("SELECT uuid, favorito FROM imovel WHERE uuid = ?", [uuid]);
    await db.close();
    return true;
  }

  Future insertImoveis(List imoveis) async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);

    for(var i in imoveis) {
      double longitude = i['longitude'];
      String tipo = i['tipo'];
      String situacao = i['situacao'];
      String data_inicio_proposta = i['data_inicio_proposta'];
      String vlr_de_venda = i['vlr_de_venda'];
      String endereco = i['endereco'];
      String tipo_leilao = i['tipo_leilao'];
      String vlr_de_avaliacao = i['vlr_de_avaliacao'];
      String estado = i['estado'];
      String id_no_leilao = i['id'];
      String versao = i['versao'];
      double latitude = i['latitude'];
      String data_termino_proposta = i['data_termino_proposta'];
      String cidade = i['cidade'];
      String bairro = i['bairro'];
      String uuid = i['uuid'];
      String descricao = i['descricao'];
      String num_do_bem = i['num_do_bem'];
      String leilao = i['leilao'];
      String favorito = i['favorito'];

      await db.rawInsert('''
        INSERT INTO imovel (
          longitude,
          tipo,
          situacao,
          data_inicio_proposta,
          vlr_de_venda,
          endereco,
          tipo_leilao,
          vlr_de_avaliacao,
          estado,
          id_no_leilao,
          versao,
          latitude,
          data_termino_proposta,
          cidade,
          bairro,
          uuid,
          descricao,
          num_do_bem,
          leilao,
          favorito        
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Não')
      ''', 
        [
          longitude, tipo, situacao, data_inicio_proposta,
          vlr_de_venda, endereco, tipo_leilao, vlr_de_avaliacao,
          estado, id_no_leilao, versao, latitude, data_termino_proposta,
          cidade, bairro, uuid, descricao, num_do_bem, leilao
        ]
      );

    }      
    await db.close();
    return true;
  }
}

