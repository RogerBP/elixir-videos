defmodule Servidor.Plugins do
  # alias Servidor.Conv, as: Conv
  alias Servidor.Conv

  def parse(request) do
    [method, path, protocol] =
      request
      |> String.replace("\r\n", "\n")
      |> String.split("\n")
      |> List.first()
      |> String.split()

    # %Servidor.Conv{method: method, path: path, protocol: protocol, status: 200}
    %Conv{method: method, path: path, protocol: protocol, status: 200}
  end

  def rewrite(%Conv{} = conv), do: Servidor.Rewriter.rewrite(conv)

  def route(%Conv{} = conv), do: Servidor.Router.route(conv)

  def format_response(%Conv{} = conv) do
    body = String.replace(conv.resp_body, "\r\n", "\n")

    """
    #{Conv.get_full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(body)}

    #{body}
    """
  end
end
