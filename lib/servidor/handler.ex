defmodule Servidor.Handler do
  def handle(request) do
    request
    |> Servidor.Plugins.parse()
    |> Servidor.Plugins.rewrite()
    |> Servidor.Plugins.route()
    |> Servidor.Plugins.format_response()
  end
end
