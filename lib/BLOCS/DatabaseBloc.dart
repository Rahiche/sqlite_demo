import 'dart:async';

import 'package:sqlite_demo/ClientModel.dart';
import 'package:sqlite_demo/Database.dart';

class ClientsBloc {
  ClientsBloc() {
    getClients();
  }

  final _clientController = StreamController<List<Client>>.broadcast();

  get clients => _clientController.stream;

  getClients() async {
    _clientController.sink.add(await DBProvider.db.getAllClients());
  }

  Future<void> blockUnblock(Client client) async {
    await DBProvider.db.blockOrUnblock(client);
    await getClients();
  }

  Future<void> delete(int id) async {
    await DBProvider.db.deleteClient(id);
    await getClients();
  }

  Future<void> add(Client client) async {
    await DBProvider.db.newClient(client);
    await getClients();
  }

  dispose() {
    _clientController.close();
  }
}
