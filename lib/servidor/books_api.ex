defmodule Servidor.BooksApi do
  alias Servidor.Book

  def books do
    [
      %Book{
        id: 1,
        title: "O homem que calculava",
        author: "Malba Tahan",
        year: 1993,
        pages: 250
      },
      %Book{
        id: 2,
        title: "A arte de ser um perfeito mau professor",
        author: "Malba Tahan",
        year: 1967,
        pages: 122
      },
      %Book{
        id: 3,
        title: "Acordaram-me de madrugada",
        author: "Malba Tahan",
        year: 1973,
        pages: 318
      },
      %Book{
        id: 4,
        title: "Antologia da matemática",
        author: "Malba Tahan",
        year: 1960,
        pages: nil
      },
      %Book{
        id: 5,
        title: "Belezas e maravilhas do céu",
        author: "Malba Tahan",
        year: 1974,
        pages: 205
      },
      %Book{
        id: 6,
        title: "Didática da matemática",
        author: "Malba Tahan",
        year: 1961,
        pages: nil
      },
      %Book{
        id: 7,
        title: "A lógica na matemática",
        author: "Malba Tahan",
        year: 1966,
        pages: 183
      },
      %Book{
        id: 8,
        title: "Matematica, Curiosa y Divertida",
        author: "Malba Tahan",
        year: 2006,
        pages: nil
      },
      %Book{
        id: 9,
        title: "Matemática divertida e delirante",
        author: "Malba Tahan",
        year: 1962,
        pages: 266
      },
      %Book{
        id: 10,
        title: "A matemática na lenda e na história",
        author: "Malba Tahan",
        year: 1974,
        pages: 225
      },
      %Book{
        id: 11,
        title: "The Lord of the Rings",
        author: "J.R.R. Tolkien",
        year: 1954,
        pages: 1193
      },
      %Book{
        id: 12,
        title: "The fellowship of the ring",
        author: "J.R.R. Tolkien",
        year: 1954,
        pages: 498
      },
      %Book{
        id: 13,
        title: "The Two Towers",
        author: "J.R.R. Tolkien",
        year: 1954,
        pages: 438
      },
      %Book{
        id: 14,
        title: "The Hobbit",
        author: "J.R.R. Tolkien",
        year: 1937,
        pages: 310
      },
      %Book{
        id: 15,
        title: "The Return of the King",
        author: "J.R.R. Tolkien",
        year: 1950,
        pages: 500
      },
      %Book{
        id: 16,
        title: "Novels (Hobbit / Lord of the Rings)",
        author: "J.R.R. Tolkien",
        year: 1979,
        pages: 1601
      },
      %Book{
        id: 17,
        title: "The Silmarillion",
        author: "J.R.R. Tolkien",
        year: 1977,
        pages: 432
      },
      %Book{
        id: 18,
        title: "Insomnia",
        author: "Stephen King",
        year: 1994,
        pages: 740
      },
      %Book{
        id: 19,
        title: "The Hobbit",
        author: "Charles Dixon",
        year: 1990,
        pages: 144
      },
      %Book{
        id: 20,
        title: "The Children of Húrin",
        author: "J.R.R. Tolkien",
        year: 2001,
        pages: 313
      },
      %Book{
        id: 21,
        title: "And Then There Were None",
        author: "Agatha Christie",
        year: 1939,
        pages: 240
      },
      %Book{
        id: 22,
        title: "Murder on the Orient Express",
        author: "Agatha Christie",
        year: 1933,
        pages: 253
      },
      %Book{
        id: 23,
        title: "The Murder of Roger Ackroyd",
        author: "Agatha Christie",
        year: 1926,
        pages: 256
      },
      %Book{
        id: 24,
        title: "The A.B.C. Murders",
        author: "Agatha Christie",
        year: 1936,
        pages: 232
      },
      %Book{
        id: 25,
        title: "Curtain",
        author: "Agatha Christie",
        year: 1975,
        pages: 238
      },
      %Book{
        id: 26,
        title: "Insomnia",
        author: "Stephen King",
        year: 1994,
        pages: 740
      },
      %Book{
        id: 27,
        title: "The Bachman Books (Long Walk / Rage / Roadwork / Running Man)",
        author: "Stephen King",
        year: 1985,
        pages: 880
      },
      %Book{
        id: 28,
        title: "The Murder at the Vicarage",
        author: "Agatha Christie",
        year: 1930,
        pages: 253
      },
      %Book{
        id: 29,
        title: "The Mysterious Affair at Styles",
        author: "Agatha Christie",
        year: 1920,
        pages: 222
      },
      %Book{
        id: 30,
        title: "The Big Four",
        author: "Agatha Christie",
        year: 1927,
        pages: 224
      }
    ]
  end

  # def get_book(id)  do
  #   IO.inspect(id)
  #   Enum.find(books(), fn b -> b.id == id end)
  # end

  def get_book(id) when is_integer(id) do
    Enum.find(books(), fn b -> b.id == id end)
  end

  def get_book(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> get_book
  end

  def get_ranking() do
    [
      get_book(1),
      get_book(11),
      get_book(30)
    ]
  end

  def get_ranking(position) do
    :timer.sleep(:timer.seconds(3))
    Enum.at(get_ranking(), position - 1)
  end
end
