import 'dart:async';
import 'dart:io';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/resources/service/db_service/db_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbServiceImpl implements DbService {
  static Database _database;
  List<RepositoriesNode> _list;
   DbServiceImpl(){
       initDB().then((value) {
         print("Database initilised");
       });
   }
  List<RepositoriesNode> get favouriteList => _list;
  Database get database => _database;
  @override
  bool  isAvailableinFavRepos(RepositoriesNode repo) {
    if(!(_list != null && _list.isNotEmpty)){
      return false;
    }else{
      return _list.any((element) => repo.name == element.name);
    }
  }
  @override
  Future<DbServiceImpl> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE favRepo ("
          "name TEXT PRIMARY KEY,"
          "owner BLOB"
          ")");
    });
    return this;
  }

  @override
  Future<void> addFavouriteRepository(RepositoriesNode repo) async {
    if(_list.contains(repo)){
      var res = await removeRepo(repo);
    return res;
    }else{
      var res = await _database.insert("favRepo", repo.toDbJson());
      print("Repo ${repo.name} added to db");
      _list.add(repo);
      return res; 
    }
    
  }

  @override
  Future<List<RepositoriesNode>> getAllFavouriteRepoList()async {
     
    var res = await _database.query("favRepo");
     _list =
        res.isNotEmpty ? res.map((c) => RepositoriesNode.fromDbJson(c)).toList() : [];
    return _list;
  }

  @override
  Future<void> removeRepo(RepositoriesNode repo) {
    // print("Repo ${repo.name} removed to db");
    _database.delete("favRepo", where: "name = ?", whereArgs: [repo.name]);
    _list.remove(repo);
    return null;
  }
}

