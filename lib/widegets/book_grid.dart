import 'package:flutter/material.dart';
import 'package:minha_prateleira/models/book.dart';
import 'package:minha_prateleira/screens/book_form_screen.dart';


class BookGrid extends StatelessWidget {
  final List<Book> books;
  final bool isFriendView;

  const BookGrid({
    super.key,
    required this.books,
    this.isFriendView = false, 
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,          
        crossAxisSpacing: 16,       
        mainAxisSpacing: 16,        
        childAspectRatio: 0.65,    
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookFormScreen(bookToEdit: book),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.black87, width: 1.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Icon(Icons.menu_book, color: Colors.grey, size: 32),
                      ),
                    ),
                    if (isFriendView)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}