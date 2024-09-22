defmodule Servidor.Router do
  alias Servidor.BooksController
  alias Servidor.Conv

  @pages_path Path.expand("../../pages", __DIR__)

  def route(%{path: "/"} = conv), do: %{conv | resp_body: "Minha biblioteca", status: 200}

  def route(%{path: "/pages/" <> file_name} = conv) do
    @pages_path
    |> Path.join(file_name)
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{path: "/books", method: "GET"} = conv),
    do: BooksController.index(conv)

  def route(%Conv{path: "/books/" <> item} = conv),
    do: BooksController.show(conv, item)

  def route(%Conv{path: "/books", method: "POST"} = conv),
    do: BooksController.create(conv)

  def route(%Conv{path: "/games"} = conv), do: get_full_resp(conv, Servidor.Api.games())

  def route(%Conv{path: "/board-games"} = conv),
    do: get_full_resp(conv, Servidor.Api.board_games())

  def route(%Conv{path: "/games/" <> item} = conv),
    do: get_resp_item(conv, Servidor.Api.games(), item)

  def route(%Conv{path: "/board-games/" <> item} = conv),
    do: get_resp_item(conv, Servidor.Api.board_games(), item)

  def route(conv), do: %{conv | resp_body: "não encontrado", status: 404}

  defp handle_file({:ok, contents}, conv), do: %{conv | resp_body: contents}

  defp handle_file({:error, :enoent}, conv),
    do: %{conv | resp_body: "File not found", status: 404}

  defp handle_file({:error, _reason}, conv), do: %{conv | resp_body: "deu zebra", status: 500}

  defp get_resp_item(conv, items, item) do
    item
    |> String.to_integer()
    |> Kernel.-(1)
    |> get_item(items)
    |> put_resp(conv)
    |> check_item_name()
  end

  defp get_full_resp(conv, items) do
    items
    |> Enum.join("\n")
    |> put_resp(conv)
  end

  defp put_resp(resp, conv), do: Map.put(conv, :resp_body, resp)

  defp get_item(item, items), do: Enum.at(items, item)

  defp check_item_name(%Conv{resp_body: nil} = conv),
    do: %{conv | resp_body: "não encontrado", status: 404}

  defp check_item_name(conv), do: conv
end
