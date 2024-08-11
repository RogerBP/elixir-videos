defmodule Servidor.Plugins do
  # alias Servidor.Conv, as: Conv
  alias Servidor.Conv

  def parse(request), do: Servidor.Parser.parse(request)

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
