defmodule Servidor.BooksController do
  alias Servidor.Book
  alias Servidor.BooksApi

  def index(conv) do
    books =
      BooksApi.books()
      |> Enum.sort(&(&1.title < &2.title))
      |> Enum.map(&book_item/1)
      |> Enum.join()

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
  def show(conv, item) do
    IO.puts("conv: #{inspect(conv)} / item: #{item}")

    book = BooksApi.get_book(item)
    resp = "<div>Id: #{book.id}/ Título: #{book.title}/ Autor: #{book.author}</div>"
    %{conv | status: 200, resp_body: resp}
  end

  # create (adicionar)
end
