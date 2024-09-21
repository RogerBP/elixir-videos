defmodule Servidor do
  @moduledoc "Servidor Elixir de Livros / Jogos e Jogos de Tabuleiro"

  @doc "Função de teste de request"
  def get(recurso) do
    exec_request("GET /#{recurso}")
  end

  def get(recurso, item) do
    exec_request("GET /#{recurso}/#{item}")
  end

  def post() do
    exec_request("POST /books", "name=Os primeiros casos de Poirot&author=Agatha Christie")
  end

  defp exec_request(comando, body \\ "") do
    request = """
    #{comando} HTTP/1.1
    Host: sabecontar.com
    User-Agent: Browser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: #{byte_size(body)}

    #{body}
    """

    IO.puts(IO.ANSI.clear())
    response = Servidor.Handler.handle(request)
    IO.puts("==========================================")
    IO.puts(response)
    IO.puts("==========================================")
  end

  @server_name "Servidor Elixir de Livros / Jogos e Jogos de Tabuleiro"

  def constante_a do
    IO.puts(@server_name)
  end

  @server_name "Elixir Server of Books / Games e Board-games"

  def constante_b do
    IO.puts(@server_name)
  end

  # O servidor abre uma porta
  #   - cria um socket e fica aguardando (escutando) por um client
  #   - neste caso o clien será o browser
  # O client (browser) envia uma requisição de conexão
  # O servidor aceita a requisição e cria um client socket
  # O cliente (browser) usa o client socket para enviar uma requisição http
  # O servidor aceita a requisição, processa e envia uma resposta pelo mesmo client socket
  # O servidor fecha o client socket e agaurda uma nova requisição

  # Erlang / OTP - Open Telecon Platform
  # Módulo: gen_tcp

  # Conversão / Transcodificação
  # Erlang                          ====> Elixir
  # fn() ->   (função)              ====> def fn do
  # lowercase (ok)                  ====> atoms (:ok)
  # uppercase (LSock)               ====> var (lsoc)
  # módulos   (gen_tcp)             ====> adicionar ":" (:gen_tcp)
  # gen_tcp:listen (função)         ====> :gen_tcp.listen
  # lista de tuplas                 ====> keywordlist
  #    {packet, 0}, {active, false} ====> {:packet, 0}, {:active, false}
  #                                 ====> packet: 0, active: false
  # linhas terminam com ","         ====> remover
  # funções terminam com "."        ====> end

  #   server() ->
  #     {ok, LSock} = gen_tcp:listen(5678, [binary, {packet, 0},
  #                                         {active, false}]),
  #     {ok, Sock} = gen_tcp:accept(LSock),
  #     {ok, Bin} = do_recv(Sock, []),  =====> :gen_tcp.recv(sock, 0)
  #     ok = gen_tcp:close(Sock),
  #     ok = gen_tcp:close(LSock),
  #     Bin.

  def server do
    port = 5678
    IO.puts("escutando na porta #{port} ...")

    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])

    # `:binary` - os dados serão tratados como binaries
    # `packet: :raw` - os dados não devem fornecidos totalmente sem manipulação de pacotes
    # `active: false` - os dados serão recebidos na chamada da função `:gen_tcp.recv/2`
    # `reuseaddr: true` - permite a reutilizaçào de endereço caso dê alguma zebra

    IO.puts("aguardando requisição ... ")

    {:ok, client_socket} = :gen_tcp.accept(listen_socket)

    IO.puts("recebendo requisição ... ")

    {:ok, request} = :gen_tcp.recv(client_socket, 0)

    IO.puts(request)

    body = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
    </head>
    <body>
        Bem vindo ao meu SITE
    </body>
    </html>
    """

    resp = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{byte_size(body)}

    #{body}
    """

    IO.puts("enviando resposta... \n#{resp} ")

    :ok = :gen_tcp.send(client_socket, resp)

    IO.puts("fechando socket... ")

    :ok = :gen_tcp.close(client_socket)
    :ok = :gen_tcp.close(listen_socket)

    IO.puts("terminado.")
  end
end
