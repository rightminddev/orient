class StoreModel {
  final String name;
  final String city;
  final String country;
  final String? imageUrl;

  StoreModel(
      {required this.name,
      required this.city,
      required this.country,
      required this.imageUrl});
}

List<StoreModel> storeModelList = [
  StoreModel(
      city: 'Cairo',
      country: "Egypt",
      name: "al-Hamad Egypt",
      imageUrl:
          'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ'),
  StoreModel(
      city: 'Cairo',
      country: "Egypt",
      name: "best first paints",
      imageUrl:
          'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ'),
  StoreModel(
      city: 'Cairo',
      country: "Egypt",
      name: "larouba psints",
      imageUrl:
          'https://imgs.search.brave.com/Uyjwuso8iIoBsKa_ts8VRhJWdSWG-slC8DgtCcCLUUg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTIx/ODEyMzY3L3Bob3Rv/L3N0b2NrZWQtc2hl/bHZlcy1pbi1ncm9j/ZXJ5LXN0b3JlLWFp/c2xlLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1ibEt6c3lQ/djB3dmQ1N2hxTW5p/RmFIQUx3VTZTa3g0/bHE5bzREMlFjQkJN/PQ'),
];
