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

  def route(%{path: "/books"} = conv), do: get_full_resp(conv, Servidor.Api.books())
  def route(%{path: "/games"} = conv), do: get_full_resp(conv, Servidor.Api.games())
  def route(%{path: "/board-games"} = conv), do: get_full_resp(conv, Servidor.Api.board_games())

  def route(%{path: "/books/" <> i} = conv), do: get_resp_item(conv, Servidor.Api.books(), i)
  def route(%{path: "/games/" <> i} = conv), do: get_resp_item(conv, Servidor.Api.games(), i)

  def route(%{path: "/board-games/" <> i} = conv),
    do: get_resp_item(conv, Servidor.Api.board_games(), i)

  def route(conv), do: %{conv | resp_body: "não encontrado"}

  def get_full_resp(conv, items) do
    items
    |> Enum.join("\n")
    |> put_resp(conv)
  end

  def put_resp(resp, conv), do: Map.put(conv, :resp_body, resp)

  def get_resp_item(conv, items, item) do
    item
    |> String.to_integer()
    |> Kernel.-(1)
    |> get_item(conv, items)
    |> check_resp
  end

  def get_item(index, conv, items), do: %{conv | resp_body: Enum.at(items, index)}

  def check_resp(%{resp_body: nil} = conv), do: %{conv | resp_body: "não encontrado"}
  def check_resp(conv), do: conv

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
