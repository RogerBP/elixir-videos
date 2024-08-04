defmodule Servidor.Handler do
  # import Servidor.Plugins
  # import Servidor.Plugins, only: [parse: 1, rewrite: 1, route: 1, format_response: 1]
  # alias Servidor.Plugins

  def handle(request) do
    request
    |> Servidor.Plugins.parse()
    |> Servidor.Plugins.rewrite()
    |> Servidor.Plugins.route()
    |> Servidor.Plugins.format_response()
  end
end
