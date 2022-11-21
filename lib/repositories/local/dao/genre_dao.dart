import 'package:objectbox/objectbox.dart';

@Entity()
class GenreDao {
  @Id(assignable: true)
  int id;
  String name;

  GenreDao({
    required this.id,
    required this.name,
  });
}
