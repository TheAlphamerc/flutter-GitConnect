import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbService{
  Future<void> initDB();
  Database get database;
  Future<void> addFavouriteRepository(RepositoriesNode repo);
  Future<List<RepositoriesNode>> getAllFavouriteRepoList();
  Future<void> removeRepo(RepositoriesNode repo);
  List<RepositoriesNode> get favouriteList;
  bool isAvailableinFavRepos(RepositoriesNode repo);
}