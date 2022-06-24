import 'package:dekoki/data/model/list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parse json restaurant into model', () {
    const id = "dwg2wt3is19kfw1e867";
    const name = "Drinky Squash";
    const description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.";
    const pictureId = "18";
    const city = "Surabaya";
    const double rating = 3.9;

    final json = {
      "id": "dwg2wt3is19kfw1e867",
      "name": "Drinky Squash",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "18",
      "city": "Surabaya",
      "rating": 3.9
    };

    Restaurant result = Restaurant.fromJson(json);
    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });

  test('convert model to json', () {
    Restaurant test = Restaurant(
      id: 'id',
      name: 'name',
      description: 'description',
      pictureId: 'pictureid',
      city: 'city',
      rating: 5);
    var expected = {
      'id': 'id',
      'name': 'name',
      'description': 'description',
      'pictureId': 'pictureid',
      'city': 'city',
      'rating': 5
    };
    var result = test.toJson();
    expect(result, expected);
  });
}