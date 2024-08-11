defmodule Servidor.Parser do
  alias Servidor.Conv

  def parse(request) do
    [header_lines, _params_line] =
      request
      |> String.replace("\r\n", "\n")
      |> String.split("\n\n")

    [method, path, protocol] =
      header_lines
      |> String.replace("\r\n", "\n")
      |> String.split("\n")
      |> List.first()
      |> String.split()

    # %Servidor.Conv{method: method, path: path, protocol: protocol, status: 200}
    %Conv{method: method, path: path, protocol: protocol, status: 200}
  end
end
