import 'package:flutter/material.dart';
import 'package:minha_prateleira/models/book.dart';

class BookFormScreen extends StatefulWidget {
  final Book? bookToEdit;

  const BookFormScreen({super.key, this.bookToEdit});

  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _reviewController;
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.bookToEdit?.title ?? '',
    );
    _reviewController = TextEditingController(
      text: widget.bookToEdit?.review ?? '',
    );
    _rating = widget.bookToEdit?.rating ?? 0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReadOnly = widget.bookToEdit?.ownerName != null;
    final isEditing = widget.bookToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isReadOnly
              ? 'Livro de ${widget.bookToEdit!.ownerName}'
              : (isEditing ? 'Edição de Livro' : 'Cadastro de Livro'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.book, size: 40, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              enabled:
                  !isReadOnly, 
              decoration: const InputDecoration(
                labelText: 'TÍTULO',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _reviewController,
              maxLines: 4,
              enabled:
                  !isReadOnly, 
              decoration: const InputDecoration(
                labelText: 'RESUMO / CRÍTICA',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: index < _rating ? Colors.amber : Colors.grey,
                    size: 32,
                  ),
                  onPressed: isReadOnly
                      ? null
                      : () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                );
              }),
            ),
            const SizedBox(height: 24),

            if (!isReadOnly)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final title = _titleController.text;
                      final review = _reviewController.text;

                      if (title.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, insira um título!'),
                          ),
                        );
                        return;
                      }

                      List<Book> updatedList = List.from(myBooksNotifier.value);

                      if (widget.bookToEdit != null) {
                        int index = updatedList.indexWhere(
                          (b) => b.id == widget.bookToEdit!.id,
                        );
                        if (index != -1) {
                          updatedList[index] = Book(
                            id: widget.bookToEdit!.id,
                            title: title,
                            review: review,
                            rating: _rating,
                          );
                        }
                      } else {
                        final newBook = Book(
                          id: DateTime.now().toString(),
                          title: title,
                          review: review,
                          rating: _rating,
                        );
                        updatedList.add(newBook);
                      }

                      myBooksNotifier.value = updatedList;

                      Navigator.pop(context);
                    },
                    child: Text(
                      widget.bookToEdit != null ? 'ATUALIZAR' : 'SALVAR',
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCELAR'),
                  ),
                ],
              )
            else
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('VOLTAR PARA A ESTANTE'),
              ),
          ],
        ),
      ),
    );
  }
}
