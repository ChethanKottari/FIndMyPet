import 'package:animal_app/networking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late List<Pet> result;
  final TextEditingController? _textController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      Provider.of<PetProvider>(context, listen: false).fetchSetPets();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Pet> petsList =
        Provider.of<PetProvider>(context, listen: true).getPets;
    List<Pet> searchResults = [];

    //print(petsList.length);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        searchResults.clear();
                        if (_textController!.text.isNotEmpty) {
                          for (int i = 0; i < petsList.length; i++) {
                            String data = petsList[i].name;
                            if (data.toLowerCase().contains(
                                _textController!.text.toLowerCase())) {
                              setState(() {
                                searchResults.add(petsList[i]);
                              });
                            }
                          }
                        } else if (_textController!.text.length == 0) {
                          setState(() {
                            searchResults = petsList;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Search pets",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 19, 16, 16)
                                .withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  const Icon(
                    Icons.search,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.tune,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        Text(" Filters",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black.withOpacity(0.5))),
                      ],
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {},
                    child: Text(
                      "less than 3 months",
                      style: TextStyle(
                          fontSize: 10, color: Colors.black.withOpacity(0.5)),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text("more than 3 months",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.5)))),
              ],
            ),
          ),
          Expanded(
              child: searchResults.length == 0 || _textController!.text.isEmpty
                  ? ListView.builder(
                      itemCount: petsList.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(petsList[index].name),
                            subtitle: Text(
                              "Age: ${petsList[index].age} months",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(searchResults[index].name),
                            subtitle: Text(
                              "Age: ${searchResults[index].age} months",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
        ],
      ),
    );
  }
}
