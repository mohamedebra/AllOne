// import 'package:flutter/material.dart';
//
// import '../home/data/model/model_products.dart';
//
// class TestApp extends StatefulWidget {
//   const TestApp({super.key});
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<TestApp> {
//   Country? selectedCountry;
//   City? selectedCity;
//   List<City> cities = [];
//   List<ProductItems> products = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("Country City Product Filter")),
//         body: Column(
//           children: <Widget>[
//             DropdownButton<Country>(
//               hint: Text("Select Country"),
//               value: selectedCountry,
//               onChanged: (Country? newValue) {
//                 setState(() {
//                   selectedCountry = newValue;
//                   cities = newValue!.cities;
//                   selectedCity = null; // Reset city selection
//                   products = []; // Reset products
//                 });
//               },
//               items: countries.map<DropdownMenuItem<Country>>((Country country) {
//                 return DropdownMenuItem<Country>(
//                   value: country,
//                   child: Text(country.name),
//                 );
//               }).toList(),
//             ),
//             DropdownButton<City>(
//               hint: Text("Select City"),
//               value: selectedCity,
//               onChanged: (City? newValue) {
//                 setState(() {
//                   selectedCity = newValue;
//                   products = newValue!.products;
//                 });
//               },
//               items: cities.map<DropdownMenuItem<City>>((City city) {
//                 return DropdownMenuItem<City>(
//                   value: city,
//                   child: Text(city.name),
//                 );
//               }).toList(),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(products[index].name!),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class FilterPage extends StatefulWidget {
//   const FilterPage({super.key});
//
//   @override
//   _FilterPageState createState() => _FilterPageState();
// }
//
// class _FilterPageState extends State<FilterPage> {
//   // Assuming your data structures are initialized here (countries, etc.)
//
//   String? selectedCountry;
//   String? selectedCity;
//
//   @override
//   Widget build(BuildContext context) {
//     // Find the selected country's cities
//     List<City> selectedCountryCities = [];
//     if (selectedCountry != null) {
//       selectedCountryCities = countries.firstWhere((country) => country.name == selectedCountry).cities;
//     }
//
//     // Find the selected city's products
//     List<ProductItems> selectedCityProducts = [];
//     if (selectedCity != null) {
//       selectedCityProducts = selectedCountryCities.firstWhere((city) => city.name == selectedCity).products;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Country, City, and Product Filter'),
//       ),
//       body: Column(
//         children: [
//           // Country selection list
//           Expanded(
//             child: ListView.builder(
//               itemCount: countries.length,
//               itemBuilder: (context, index) {
//                 Country country = countries[index];
//                 return CheckboxListTile(
//                   title: Text(country.name),
//                   value: selectedCountry == country.name,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       selectedCountry = value! ? country.name : null;
//                       selectedCity = null; // Reset city selection
//                       // This also implicitly clears the product selection by resetting the city
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           // City selection list based on selected country
//           if (selectedCountry != null)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: selectedCountryCities.length,
//                 itemBuilder: (context, index) {
//                   City city = selectedCountryCities[index];
//                   return CheckboxListTile(
//                     title: Text(city.name),
//                     value: selectedCity == city.name,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         selectedCity = value! ? city.name : null;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//           // Product display based on selected city
//           if (selectedCity != null)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: selectedCityProducts.length,
//                 itemBuilder: (context, index) {
//                   ProductItems product = selectedCityProducts[index];
//                   return ListTile(
//                     title: Text(product.name!),
//                     subtitle: Text(product.details!),
//                     leading: Image.asset(product.image!), // Ensure the image path is correct
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }