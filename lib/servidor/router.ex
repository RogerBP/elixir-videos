defmodule Servidor.Router do
  alias Servidor.BooksController
  alias Servidor.Conv

  @pages_path Path.expand("../../pages", __DIR__)

  def route(%{path: "/"} = conv) do
    %{conv | resp_body: "#{now()} Minha biblioteca", status: 200}
  end

  def route(%{path: "/timer/" <> time} = conv) do
    String.to_integer(time)
    |> :timer.sleep()

    %{conv | resp_body: "Dormindo por #{time} ms"}
  end

  def route(%{path: "/ranking"} = conv) do
    {t_ini, ini} = now()
    parent = self()

    spawn(fn -> send(parent, Servidor.BooksApi.get_ranking(1)) end)
    spawn(fn -> send(parent, Servidor.BooksApi.get_ranking(2)) end)
    spawn(fn -> send(parent, Servidor.BooksApi.get_ranking(3)) end)

    primeiro =
      receive do
        msg -> msg
      end

    segundo =
      receive do
        msg -> msg
      end

    terceiro =
      receive do
        msg -> msg
      end

    {t_fim, fim} = now()
    tempo = Time.diff(t_fim, t_ini, :millisecond)

    body =
      """
      #{ini} => #{fim} : #{tempo} ms
      <div>1 - #{primeiro.id} - #{primeiro.title}</div>
      <div>2 - #{segundo.id} - #{segundo.title}</div>
      <div>3 - #{terceiro.id} - #{terceiro.title}</div>
      """

    %{conv | resp_body: body}
  end

  def route(%{path: "/zebra"}) do
    raise "... deu zebra ..."
  end

  def route(%{path: "/zebra/1"}) do
    raise ArgumentError, message: "... deu zebra ..."
  end

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

  defp now() do
    t = Time.utc_now()

    str =
      t
      |> Time.truncate(:second)
      |> Time.to_string()

    {t, str}
  end
end
