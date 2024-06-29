defmodule Servidor do
  @moduledoc """
  Servidor de testes em Elixir
  """
  @server_name "servidor elixir"

  @doc """
  Função de teste de request
  """
  def testar(recurso) do
    exec_request("GET /#{recurso}")
    IO.puts(@server_name)
  end

  def testar(recurso, item) do
    exec_request("GET /#{recurso}/#{item}")
  end

  defp exec_request(comando) do
    request = """
    #{comando} HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*

    """

    response = Servidor.Handler.handle(request)
    IO.puts(IO.ANSI.clear())
    IO.puts("==========================================")
    IO.puts(response)
    IO.puts("==========================================")
    IO.puts("\n\n\n\n")
  end
end
