import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {
  Database _db;

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    _db = await openDatabase(dbPath, version: 1, onCreate: this._create);
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
          pimax REAL NOT NULL,
          pemax REAL NOT NULL,
          pimaxnormal REAL NOT NULL,
          pemaxnormal REAL NOT NULL,
          repousofc INTEGER,
          repousofr INTEGER,
          repousospo INTEGER,
          repousopa TEXT,
          repousobrogd INTEGER,
          repousommii INTEGER,
          repousooxigenio TEXT,
          min3fc INTEGER,
          min3spo INTEGER,
          min3oxigenio TEXT,
          min6fc INTEGER,
          min6fr INTEGER,
          min6spo INTEGER,
          min6pa TEXT,
          min6brogd INTEGER,
          min6mmii INTEGER,
          min6oxigenio TEXT,
          repouso2fc INTEGER,
          repouso2fr INTEGER,
          repouso2spo INTEGER,
          repouso2pa TEXT,
          repouso2brogd INTEGER,
          repouso2mmii INTEGER,
          repouso2oxigenio TEXT,
          distancia INTEGER NOT NULL,
          tc6min REAL NOT NULL,
          vo2pico REAL NOT NULL,
          data TEXT NOT NULL
        )
      """
    );

    //await db.execute(
    //  """
    //    CREATE TABLE login (
    //      id INTEGER PRIMARY KEY,
    //      user TEXT NOT NULL,
    //      email TEXT NOT NULL,
    //      accesstoken TEXT NOT NULL,
    //      authuser TEXT NOT NULL
    //    )
    //  """
    //);

  }
}

class BancoDados {
  BancoDados();
  Database db;

  Future getTodosPacientes() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    List results = await db.rawQuery("SELECT id, nome, data FROM formulario");
    await db.close();
    return results;
  }

  Future getFormulario(id) async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    List results = await db.rawQuery("SELECT * FROM formulario WHERE id = ?", [id]);
    await db.close();
    return results;
  }

  //Future insertLogin(String user, String email, String accesstoken, String authuser) async {
  //  Directory path = await getApplicationDocumentsDirectory();
  //  String dbPath = join(path.path, "database.db");
  //  Database db = await openDatabase(dbPath);
  //  await db.rawDelete("DELETE FROM login").then((data) async {
  //    await db.rawInsert("INSERT INTO login (user, email, accesstoken, authuser) VALUES (?, ?, ?, ?)", [user, email, accesstoken, authuser]);
  //    await db.close();
  //  });          
  //  return true;
  //}

  Future deletePaciente(id) async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);
    await db.rawDelete("DELETE FROM formulario WHERE id = ?", [id]);        
    await db.close();
    return true;
  }

  Future insertForm(Map form) async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);

    String nome = form['nome'];
    String genero = form['genero'];
    int idade = form['idade'];
    double peso = form['peso'];
    int altura = form['altura'];
    double pimax = form['pimax'];
    double pemax = form['pemax'];
    double pimaxnormal = form['pimaxnormal'];
    double pemaxnormal = form['pemaxnormal'];
    int repousofc = form['repousofc'];
    int repousofr = form['repousofr'];
    int repousospo = form['repousospo'];
    String repousopa = form['repousopa'];
    int repousobrogd = form['repousobrogd'];
    int repousommii = form['repousommii'];
    String repousooxigenio = form['repousooxigenio'];
    int min3fc = form['min3fc'];
    int min3spo = form['min3spo'];
    String min3oxigenio = form['min3oxigenio'];
    int min6fc = form['min6fc'];
    int min6fr = form['min6fr'];
    int min6spo = form['min6spo'];
    String min6pa = form['min6pa'];
    int min6brogd = form['min6brogd'];
    int min6mmii = form['min6mmii'];
    String min6oxigenio = form['min6oxigenio'];
    int repouso2fc = form['repouso2fc'];
    int repouso2fr = form['repouso2fr'];
    int repouso2spo = form['repouso2spo'];
    String repouso2pa = form['repouso2pa'];
    int repouso2brogd = form['repouso2brogd'];
    int repouso2mmii = form['repouso2mmii'];
    String repouso2oxigenio = form['repouso2oxigenio'];
    int distancia = form['distancia'];
    double tc6min = form['tc6min'];
    double vo2pico = form['vo2pico'];
    String data = form['data'];


    await db.rawInsert(
      '''INSERT INTO formulario
      (
        nome,
        genero,
        idade,
        peso,
        altura,
        pimax,
        pemax,
        pimaxnormal,
        pemaxnormal,
        repousofc,
        repousofr,
        repousospo,
        repousopa,
        repousobrogd,
        repousommii,
        repousooxigenio,
        min3fc,
        min3spo,
        min3oxigenio,
        min6fc,
        min6fr,
        min6spo,
        min6pa,
        min6brogd,
        min6mmii,
        min6oxigenio,
        repouso2fc,
        repouso2fr,
        repouso2spo,
        repouso2pa,
        repouso2brogd,
        repouso2mmii,
        repouso2oxigenio,
        distancia,
        tc6min,
        vo2pico,
        data
      ) VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
      )''', [
        nome,
        genero,
        idade,
        peso,
        altura,
        pimax,
        pemax,
        pimaxnormal,
        pemaxnormal,
        repousofc,
        repousofr,
        repousospo,
        repousopa,
        repousobrogd,
        repousommii,
        repousooxigenio,
        min3fc,
        min3spo,
        min3oxigenio,
        min6fc,
        min6fr,
        min6spo,
        min6pa,
        min6brogd,
        min6mmii,
        min6oxigenio,
        repouso2fc,
        repouso2fr,
        repouso2spo,
        repouso2pa,
        repouso2brogd,
        repouso2mmii,
        repouso2oxigenio,
        distancia,
        tc6min,
        vo2pico,
        data
      ]
    );
    await db.close();       
    return true;
  }

  Future updateForm(Map form) async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");
    Database db = await openDatabase(dbPath);

    print(form);

    String nome = form['nome'];
    String genero = form['genero'];
    int idade = form['idade'];
    double peso = form['peso'];
    int altura = form['altura'];
    double pimax = form['pimax'];
    double pemax = form['pemax'];
    double pimaxnormal = form['pimaxnormal'];
    double pemaxnormal = form['pemaxnormal'];
    int repousofc = form['repousofc'];
    int repousofr = form['repousofr'];
    int repousospo = form['repousospo'];
    String repousopa = form['repousopa'];
    int repousobrogd = form['repousobrogd'];
    int repousommii = form['repousommii'];
    String repousooxigenio = form['repousooxigenio'];
    int min3fc = form['min3fc'];
    int min3spo = form['min3spo'];
    String min3oxigenio = form['min3oxigenio'];
    int min6fc = form['min6fc'];
    int min6fr = form['min6fr'];
    int min6spo = form['min6spo'];
    String min6pa = form['min6pa'];
    int min6brogd = form['min6brogd'];
    int min6mmii = form['min6mmii'];
    String min6oxigenio = form['min6oxigenio'];
    int repouso2fc = form['repouso2fc'];
    int repouso2fr = form['repouso2fr'];
    int repouso2spo = form['repouso2spo'];
    String repouso2pa = form['repouso2pa'];
    int repouso2brogd = form['repouso2brogd'];
    int repouso2mmii = form['repouso2mmii'];
    String repouso2oxigenio = form['repouso2oxigenio'];
    int distancia = form['distancia'];
    double tc6min = form['tc6min'];
    double vo2pico = form['vo2pico'];
    String data = form['data'];

    await db.rawUpdate(
      '''UPDATE formulario SET      
        nome = ?,
        genero = ?,
        idade = ?,
        peso = ?,
        altura = ?,
        pimax = ?,
        pemax = ?,
        pimaxnormal = ?,
        pemaxnormal = ?,
        repousofc = ?,
        repousofr = ?,
        repousospo = ?,
        repousopa = ?,
        repousobrogd = ?,
        repousommii = ?,
        repousooxigenio = ?,
        min3fc = ?,
        min3spo = ?,
        min3oxigenio = ?,
        min6fc = ?,
        min6fr = ?,
        min6spo = ?,
        min6pa = ?,
        min6brogd = ?,
        min6mmii = ?,
        min6oxigenio = ?,
        repouso2fc = ?,
        repouso2fr = ?,
        repouso2spo = ?,
        repouso2pa = ?,
        repouso2brogd = ?,
        repouso2mmii = ?,
        repouso2oxigenio = ?,
        distancia = ?,
        tc6min = ?,
        vo2pico = ?,
        data = ?
      WHERE id = ? ''', [
        nome,
        genero,
        idade,
        peso,
        altura,
        pimax,
        pemax,
        pimaxnormal,
        pemaxnormal,
        repousofc,
        repousofr,
        repousospo,
        repousopa,
        repousobrogd,
        repousommii,
        repousooxigenio,
        min3fc,
        min3spo,
        min3oxigenio,
        min6fc,
        min6fr,
        min6spo,
        min6pa,
        min6brogd,
        min6mmii,
        min6oxigenio,
        repouso2fc,
        repouso2fr,
        repouso2spo,
        repouso2pa,
        repouso2brogd,
        repouso2mmii,
        repouso2oxigenio,
        distancia,
        tc6min,
        vo2pico,
        data
      ]
    );

    List results2 = await db.rawQuery("SELECT * FROM formulario WHERE id = 4");
    print(results2);
    await db.close();       
    return true;
  }
  

  //Future getFavorito(String uuid) async {
  //  bool favorito = false;
  //  Directory path = await getApplicationDocumentsDirectory();
  //  String dbPath = join(path.path, "database.db");
  //  Database db = await openDatabase(dbPath);
  //  List results = await db.rawQuery("SELECT uuid, favorito FROM imovel WHERE uuid = ?", [uuid]);
  //  if(results[0]['favorito'] == "Não") {
  //    favorito = true;
  //  }
  //  await db.close();
  //  return favorito;
  //}
//
  //Future getAllFavorito() async {
  //  Directory path = await getApplicationDocumentsDirectory();
  //  String dbPath = join(path.path, "database.db");
  //  Database db = await openDatabase(dbPath);
  //  List results = await db.rawQuery("SELECT * FROM imovel WHERE favorito = 'Sim'");
  //  await db.close();
  //  return results;
  //}
//
  //Future updateFavorito(String uuid, String valor) async {
  //  bool favorito = false;
  //  Directory path = await getApplicationDocumentsDirectory();
  //  String dbPath = join(path.path, "database.db");
  //  Database db = await openDatabase(dbPath);
  //  await db.rawUpdate("UPDATE imovel SET favorito = ? WHERE uuid = ?", [valor, uuid]);
  //  List results = await db.rawQuery("SELECT uuid, favorito FROM imovel WHERE uuid = ?", [uuid]);
  //  await db.close();
  //  return true;
  //}
//
  //Future insertImoveis(List imoveis) async {
  //  Directory path = await getApplicationDocumentsDirectory();
  //  String dbPath = join(path.path, "database.db");
  //  Database db = await openDatabase(dbPath);
//
  //  for(var i in imoveis) {
  //    double longitude = i['longitude'];
  //    String tipo = i['tipo'];
  //    String situacao = i['situacao'];
  //    String data_inicio_proposta = i['data_inicio_proposta'];
  //    String vlr_de_venda = i['vlr_de_venda'];
  //    String endereco = i['endereco'];
  //    String tipo_leilao = i['tipo_leilao'];
  //    String vlr_de_avaliacao = i['vlr_de_avaliacao'];
  //    String estado = i['estado'];
  //    String id_no_leilao = i['id'];
  //    String versao = i['versao'];
  //    double latitude = i['latitude'];
  //    String data_termino_proposta = i['data_termino_proposta'];
  //    String cidade = i['cidade'];
  //    String bairro = i['bairro'];
  //    String uuid = i['uuid'];
  //    String descricao = i['descricao'];
  //    String num_do_bem = i['num_do_bem'];
  //    String leilao = i['leilao'];
  //    String favorito = i['favorito'];
//
  //    await db.rawInsert('''
  //      INSERT INTO imovel (
  //        longitude,
  //        tipo,
  //        situacao,
  //        data_inicio_proposta,
  //        vlr_de_venda,
  //        endereco,
  //        tipo_leilao,
  //        vlr_de_avaliacao,
  //        estado,
  //        id_no_leilao,
  //        versao,
  //        latitude,
  //        data_termino_proposta,
  //        cidade,
  //        bairro,
  //        uuid,
  //        descricao,
  //        num_do_bem,
  //        leilao,
  //        favorito        
  //      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Não')
  //    ''', 
  //      [
  //        longitude, tipo, situacao, data_inicio_proposta,
  //        vlr_de_venda, endereco, tipo_leilao, vlr_de_avaliacao,
  //        estado, id_no_leilao, versao, latitude, data_termino_proposta,
  //        cidade, bairro, uuid, descricao, num_do_bem, leilao
  //      ]
  //    );
//
  //  }      
  //  await db.close();
  //  return true;
  //}
}

