import 'package:objectbox/objectbox.dart';

@Entity()
class FavouritesDao {
  @Id(assignable: true)
  int id;

  FavouritesDao({
    required this.id,
  });
}
