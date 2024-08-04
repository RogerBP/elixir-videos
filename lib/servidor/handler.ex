defmodule Servidor.Handler do
  # import Servidor.Plugins
  import Servidor.Plugins, only: [parse: 1, rewrite: 1, route: 1, format_response: 1]

  def handle(request) do
    request
    |> parse()
    |> rewrite()
    |> route()
    |> format_response()
  end
end
