import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/model/news_model.dart';
import 'package:task2/provider/provider.dart';
import 'package:task2/screen/artical_screen.dart';
import 'package:task2/utils/home_button.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> allArticles = [];
  int currentPage = 1;
  bool isLoading = false;
  String errorLogs = '';
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      errorLogs = '';
    });

    Provider.of<NewsProvider>(context, listen: false)
        .getTopHeadlinesCategory(widget.category, currentPage, '')
        .then((newArticles) {
      setState(() {
        // if (searchTerm.isEmpty) {
        //   currentPage++;
        // }
        currentPage++;
        allArticles.addAll(newArticles);
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
        errorLogs = error.toString();
        log(errorLogs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
          actions: [
            HomeButton(),
          ],
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CupertinoSearchTextField(
            //     style: TextStyle(
            //         color: Theme.of(context).textTheme.bodyLarge?.color),
            //     controller: searchController,
            //     onChanged: (value) {
            //       setState(() {
            //         allArticles.clear();
            //       });
            //       _loadArticles(searchTerm: value);
            //     },
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.grey),
            //       color: Colors.transparent,
            //       borderRadius: const BorderRadius.all(
            //         Radius.circular(5),
            //       ),
            //     ),
            //     placeholder: "Search ${widget.category}",
            //   ),
            // ),
            Expanded(
              child: errorLogs.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: $errorLogs',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () => _loadArticles(),
                          child: Text('Retry'),
                        )
                      ],
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          _loadArticles();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: allArticles.length + (isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == allArticles.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (allArticles.isEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: Text("No data found"),
                              ),
                            );
                          }
                          final Article news = allArticles[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(
                                  news.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      news.description ??
                                          'No description available.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Read more...',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticalScreen(
                                        article: news,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ));
  }
}
