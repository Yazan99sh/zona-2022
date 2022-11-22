import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:zona/generated/l10n.dart';
import 'package:zona/src/features/models/category.dart';
import 'package:zona/src/features/view/screens/SubCategoriesScreen.dart';

import '../../../../config/routing.dart';
import '../../../../utils/text_input_decoration.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key, required this.categories}) : super(key: key);
  List<Category> categories;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          obscureText: false,
          keyboardType: TextInputType.text,
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
          decoration: kTextFieldDecoration.copyWith(
              suffixIcon: Container(
                child: const Center(
                  child: Icon(
                    IconlyLight.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                margin: const EdgeInsets.fromLTRB(0, 6, 10, 6),
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff1A1B2D)),
              ),
              hintText: S.current.searchCategories,
              hintStyle: const TextStyle()),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        color: const Color.fromRGBO(249, 249, 249, 1),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "I  ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(202, 189, 255, 1),
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    S.current.allCategories,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(26, 29, 31, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GridView.count(
                    childAspectRatio: 6 / 9,
                    crossAxisCount: 3,
                    children: List.generate(widget.categories.length, (index) {
                      String color =
                          '0x' + widget.categories[index].color.toString();
                      if (widget.categories
                          .elementAt(index)
                          .name
                          .toString()
                          .toLowerCase()
                          .contains(name.toString().toLowerCase())) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    Routing().createRoute(CategoryProviders(
 idCategory: widget.categories[index].id.toString(),
                          categoryName: widget.categories[index].name,                                      
                                  dashboardView: false,
                                )));
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(
                                    int.parse(color),
                                  ),
                                ),
                                child: Image.network(
                                  widget.categories[index].image.toString(),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Text(
                              widget.categories[index].name.toString(),
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(65, 64, 93, 1)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
