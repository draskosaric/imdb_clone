import 'package:imdb_clone/repositories/local/dao/genre_dao.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MovieDao {
  @Id(assignable: true)
  int id;
  String title;
  double averageVote;
  final genres = ToMany<GenreDao>();
  //List<GenreDao> genres;
  String description;
  String posterPath;
  @Index()
  int orderNumber;

  MovieDao({
    required this.id,
    required this.title,
    required this.averageVote,
    required this.description,
    required this.posterPath,
    required this.orderNumber,
  });
}
