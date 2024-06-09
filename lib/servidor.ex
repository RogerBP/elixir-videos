defmodule Servidor do
  def testar do
    request = """
    GET /games HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*

    """

    response = Servidor.Handler.handle(request)
    IO.puts(response)
  end
end
