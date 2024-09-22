defmodule Servidor.Plugins do
  # alias Servidor.Conv, as: Conv
  alias Servidor.Conv

  def parse(request), do: Servidor.Parser.parse(request)

  def rewrite(%Conv{} = conv), do: Servidor.Rewriter.rewrite(conv)

  def route(%Conv{} = conv), do: Servidor.Router.route(conv)

  def format_response(%Conv{} = conv) do
    body = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
    </head>
    <body>
        #{String.replace(conv.resp_body, "\r\n", "\n")}
    </body>
    </html>
    """

    """
    #{Conv.get_full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(body)}

    #{body}
    """
  end
end
