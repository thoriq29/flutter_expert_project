
import 'package:tv/domain/repository/tv_repository.dart';

class GetWatchListStatus {
  final TvRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
