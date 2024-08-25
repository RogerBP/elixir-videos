defmodule Servidor.BooksController do
  alias Servidor.Book
  alias Servidor.BooksApi

  def index(conv) do
    books = BooksApi.books()
    # books = Enum.sort(books, fn a, b -> a.title < b.title end)
    books = Enum.sort(books, &(&1.title < &2.title))
    # books = Enum.sort(books, &(&1.id < &2.id))

    # items = Enum.map(books, fn book -> book_item(book) end)
    # items = Enum.map(books, &book_item(&1))
    books = Enum.map(books, &book_item/1)

    books = Enum.join(books)

    resp =
      """
        <h1>Meus Livros<h2>
        <ul>
          #{books}
        <ul>
      """

    %{conv | status: 200, resp_body: resp}
  end

  defp book_item(%Book{} = book) do
    "\n<li>Id: #{book.id}/ Título: #{book.title}/ Autor: #{book.author}</li>"
  end

  # show (mostra um)
  # create (adicionar)
end
