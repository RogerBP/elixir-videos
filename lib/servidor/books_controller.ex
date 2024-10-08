defmodule Servidor.BooksController do
  alias Servidor.Book
  alias Servidor.BooksApi

  @templates_path Path.expand("../../templates", __DIR__)

  def index(conv) do
    books =
      BooksApi.books()
      |> Enum.sort(&(&1.title < &2.title))

    # |> Enum.map(&book_item/1)
    # |> Enum.join()

    # html = """
    # <h1>Meus livros</h1>
    # <ul><%= for book <- books, book.author == "Stephen King" do %>
    # <%= Servidor.BooksController.book_item(book) %>
    # <% end %>
    # </ul>
    # """

    # resp = EEx.eval_string(html, books: books)

    render(conv, "books_index.eex", books: books)
  end

  def show(conv, item) do
    render(conv, "books_show.eex", book: BooksApi.get_book(item))
  end

  def render(conv, template, dados) do
    resp =
      Path.join(@templates_path, template)
      |> EEx.eval_file(dados)

    %{conv | status: 200, resp_body: resp}
  end

  def book_item(%Book{} = book) do
    "\n<li>Id: #{book.id}/ Título: #{book.title}/ Autor: #{book.author}</li>"
  end

  def create(conv) do
    resp = "Novo livro: #{conv.params["name"]} - #{conv.params["author"]}"
    %{conv | status: 200, resp_body: resp}
  end
end
