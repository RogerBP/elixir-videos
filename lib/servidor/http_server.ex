defmodule Servidor.HttpServer do
  def start(port) when port > 1023 do
    IO.puts("===> 🎧 ===> Escutando na porta #{port} ...\n")

    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])

    accept_connection(listen_socket)
  end

  def accept_connection(listen_socket) do
    IO.puts("===> 🌎 <=== Aguardando conexão ... \n")

    {:ok, client_socket} = :gen_tcp.accept(listen_socket)

    IO.puts("===> ✨ <=== Conectado ... \n")

    {:ok, request} = :gen_tcp.recv(client_socket, 0)

    IO.puts("===> 📃 <=== Requisição recebida ... \n")
    IO.puts(request)
    IO.puts("\n================================= \n")

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

    IO.puts("===> 📜 <=== Enviando resposta... \n#{resp} \n")

    :ok = :gen_tcp.send(client_socket, resp)

    IO.puts("===> 🚫 <=== Fechando socket... \n")

    :ok = :gen_tcp.close(client_socket)
    # :ok = :gen_tcp.close(listen_socket)

    accept_connection(listen_socket)
  end
end

# socket options :
# `:binary` - os dados serão tratados como binaries
# `packet: :raw` - os dados não devem fornecidos totalmente sem manipulação de pacotes
# `active: false` - os dados serão recebidos na chamada da função `:gen_tcp.recv/2`
# `reuseaddr: true` - permite a reutilizaçào de endereço caso dê alguma zebra

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
