import 'package:book_shop_flutter/bloc/books_bloc.dart';
import 'package:book_shop_flutter/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/repository.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key});
  @override
  State<BooksList> createState() => _BooksState();
}

const List<int> list = <int>[
  10,
  20,
  50,
  100,
];
BooksRepository booksRepository = BooksRepository();

class _BooksState extends State<BooksList> {
  int dropDownValue = 10;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => booksRepository,
      child: BlocProvider(
        create: (context) => BooksBloc(booksRepository)..add(LoadBooksEvent(quantity: 10)),
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(225, 117, 133, 219),
              automaticallyImplyLeading: false,
              title: const Text(
                'BOOKSHOP',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: DropdownButtonExample(),
                ),
              ]),
          body: BlocBuilder<BooksBloc, BooksState>(
            builder: (context, state) {
              if (state.status == BooksStateStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: state.books?.length,
                  // prototypeItem: ListTile(
                  //   title: Text(items.first),
                  // ),
                  itemBuilder: (context, index) => bookTemplate(state.books?[index] ?? BooksModel()));
            },
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  int dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(builder: (context, booksState) {
      return DropdownButton<int>(
        value: booksState.quantity,
        icon: const Icon(
          Icons.arrow_downward,
          color: Color.fromARGB(255, 27, 2, 95),
        ),
        elevation: 16,
        style: const TextStyle(
          color: Color.fromARGB(255, 27, 2, 95),
          fontSize: 18,
        ),
        underline: Container(
          height: 2,
          color: const Color.fromARGB(255, 27, 2, 95),
        ),
        onChanged: (int? value) {
          context.read<BooksBloc>().add(LoadBooksEvent(quantity: value));
        },
        items: list.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      );
    });
  }
}

Widget bookTemplate(BooksModel model) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    color: const Color.fromARGB(255, 214, 214, 214),
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 90,
                  color: const Color(0xff7585db),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 21.0),
                  child: Text(
                    model.genre.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 221,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    model.author.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: Text(
                    model.description.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
                  child: Text(
                    model.number.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 221,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.publisher.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        model.datePublished.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
