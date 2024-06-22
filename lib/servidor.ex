defmodule Servidor do
  def testar(recurso) do
    exec_request("GET /#{recurso}")
  end

  def testar(recurso, item) do
    exec_request("GET /#{recurso}/#{item}")
  end

  def exec_request(comando) do
    request = """
    #{comando} HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*

    """

    response = Servidor.Handler.handle(request)
    IO.puts("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    IO.puts("=========================================")
    IO.puts(response)
    IO.puts("=========================================")
    IO.puts("\n\n\n\n")
  end
end
