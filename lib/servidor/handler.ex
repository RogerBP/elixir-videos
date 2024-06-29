defmodule Servidor.Handler do
  def handle(request) do
    request
    |> parse
    |> rewrite
    |> route
    |> format_response
  end

  defp parse(request) do
    [method, path, protocol] =
      request
      |> String.replace("\r\n", "\n")
      |> String.split("\n")
      |> List.first()
      |> String.split()

    %{method: method, path: path, protocol: protocol, resp_body: "", status: 200}
  end

  defp rewrite(%{path: "/livros"} = conv), do: %{conv | path: "/books"}
  defp rewrite(%{path: "/jogos"} = conv), do: %{conv | path: "/games"}
  defp rewrite(%{path: "/tabuleiros"} = conv), do: %{conv | path: "/board-games"}
  defp rewrite(conv), do: conv

  defp route(%{path: "/books"} = conv), do: get_full_resp(conv, Servidor.Api.books())

  defp route(%{path: "/games"} = conv), do: get_full_resp(conv, Servidor.Api.games())

  defp route(%{path: "/board-games"} = conv), do: get_full_resp(conv, Servidor.Api.board_games())

  defp route(%{path: "/books/" <> item} = conv),
    do: get_resp_item(conv, Servidor.Api.books(), item)

  defp route(%{path: "/games/" <> item} = conv),
    do: get_resp_item(conv, Servidor.Api.games(), item)

  defp route(%{path: "/board-games/" <> item} = conv),
    do: get_resp_item(conv, Servidor.Api.board_games(), item)

  defp route(conv), do: %{conv | resp_body: "não encontrado", status: 404}

  defp get_resp_item(conv, items, item) do
    item
    |> String.to_integer()
    |> Kernel.-(1)
    |> get_item(items)
    |> put_resp(conv)
    |> check_item_name()
  end

  defp put_resp(resp, conv), do: Map.put(conv, :resp_body, resp)

  defp get_full_resp(conv, items) do
    items
    |> Enum.join("\n")
    |> put_resp(conv)
  end

  defp get_item(item, items), do: Enum.at(items, item)

  defp check_item_name(%{resp_body: nil} = conv),
    do: %{conv | resp_body: "não encontrado", status: 404}

  defp check_item_name(conv), do: conv

  defp format_response(conv) do
    body = String.replace(conv.resp_body, "\r\n", "\n")

    """
    #{conv.protocol} #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(body)}

    #{body}
    """
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
