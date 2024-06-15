defmodule Servidor do
  def testar do
    request = """
    GET /books/4 HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*

    """

    response = Servidor.Handler.handle(request)
    IO.puts("=========================================")
    IO.puts(response)
    IO.puts("=========================================")
  end
end
