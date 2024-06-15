defmodule Servidor.Handler do
  def handle(request) do
    request
    |> parse
    |> route
    |> format_response
  end

  def parse(request) do
    [method, path, protocol] =
      request
      |> String.replace("\r\n", "\n")
      |> String.split("\n")
      |> List.first()
      |> String.split()

    %{method: method, path: path, protocol: protocol, resp_body: ""}
  end

  def route(%{path: "/books"} = conv) do
    resp_body =
      books()
      |> Enum.join("\n")

    %{
      conv
      | resp_body: resp_body
    }
  end

  def route(%{path: "/books/" <> i} = conv) do
    resp_body =
      i
      |> String.to_integer()
      |> Kernel.-(1)
      |> get_book
      |> check_book_name

    %{
      conv
      | resp_body: resp_body
    }
  end

  def route(%{path: "/games"} = conv) do
    resp_body =
      games()
      |> Enum.join("\n")

    %{
      conv
      | resp_body: resp_body
    }
  end

  def route(%{path: "/board-games"} = conv) do
    resp_body =
      board_games()
      |> Enum.join("\n")

    %{
      conv
      | resp_body: resp_body
    }
  end

  def route(conv) do
    %{
      conv
      | resp_body: "não encontrado"
    }
  end

  def get_book(index) do
    Enum.at(books(), index)
  end

  def check_book_name(nil) do
    "não encontrado"
  end

  def check_book_name(book_name), do: book_name

  def books do
    [
      "O homem que calculava, Malba Tahan",
      "StarWars - Herdeiros do Império, Timothy Zhan",
      "O Silmarilion - J.R.R.Tolkien"
    ]
  end

  def games do
    [
      "Factorio, Wube Software LTD.",
      "Satisfactory, Coffee Stain Studios",
      "TerraTech, Payload Studios"
    ]
  end

  def board_games() do
    [
      "Terraforming mars, Jacob Frixelius",
      "Quartz, Sergio Halaban",
      "Azul, Michael Kiesling"
    ]
  end

  def format_response(conv) do
    body = String.replace(conv.resp_body, "\r\n", "\n")

    """
    #{conv.protocol} 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(body)}

    #{body}
    """
  end
end
