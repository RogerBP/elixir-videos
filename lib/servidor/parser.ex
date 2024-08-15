defmodule Servidor.Parser do
  alias Servidor.Conv

  def parse(request) do
    [header_lines, params_line] =
      request
      |> String.replace("\r\n", "\n")
      |> String.split("\n\n")

    top_lines =
      header_lines
      |> String.split("\n")

    [top_line | headers_lines] = top_lines

    headers = Servidor.Utils.list_to_map(headers_lines, %{})

    [method, path, protocol] =
      top_line
      |> String.split()

    # %Servidor.Conv{method: method, path: path, protocol: protocol, status: 200}
    # %Conv{method: method, path: path, protocol: protocol, status: 200}

    params = parse_params(headers["Content-Type"], params_line)

    # %Conv{
    #   method: method,
    #   path: path,
    #   protocol: protocol,
    #   status: 200,
    #   params: params
    # }

    # %Conv{
    #   method: method,
    #   path: path,
    #   protocol: protocol,
    #   status: 200,
    #   params: params,
    #   headers: headers_lines
    # }

    %Conv{
      method: method,
      path: path,
      protocol: protocol,
      status: 200,
      params: params,
      headers: headers
    }
  end

  defp parse_params("application/x-www-form-urlencoded", params_line) do
    URI.decode_query(String.trim(params_line))
  end

  defp parse_params(_, _), do: nil
end
