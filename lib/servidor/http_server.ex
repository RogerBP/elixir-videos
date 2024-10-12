defmodule Servidor.HttpServer do
  def start(port) when port > 1023 do
    log("🎧 ===> Escutando na porta #{port} ...")

    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])

    accept_connection(listen_socket)
    # try do
    #   accept_connection(listen_socket)
    # rescue
    #   e in RuntimeError -> tratar_erro(listen_socket, e)
    # end
  end

  # defp tratar_erro(listen_socket, error) do
  #   :ok = :gen_tcp.close(listen_socket)
  #   raise error
  # end

  defp accept_connection(listen_socket) do
    log("🌎 <=== Aguardando conexão ...")
    {:ok, client_socket} = :gen_tcp.accept(listen_socket)
    log("✨ <=== Conectado ...")
    spawn(fn -> serve(client_socket) end)
    accept_connection(listen_socket)
  end

  defp serve(client_socket) do
    request = get_request(client_socket)
    resp = get_resp(request)
    send_response(resp, client_socket)
    close_socket(client_socket)
  end

  defp send_response(resp, client_socket) do
    log("📜 <=== Enviando resposta... ")
    :ok = :gen_tcp.send(client_socket, resp)
  end

  defp close_socket(client_socket) do
    log("🚫 <=== Fechando socket... ")
    :ok = :gen_tcp.close(client_socket)
  end

  defp get_resp(request) do
    Servidor.Handler.handle(request)
  end

  defp get_request(client_socket) do
    log("📃 <=== Aguardando Requisição ...")

    :gen_tcp.recv(client_socket, 0)
    |> tratar_request()
  end

  defp tratar_request({:ok, request}) do
    linha = get_first_line(request)
    log("📃 <=== Requisição recebida: #{linha}")
    request
  end

  defp tratar_request({:error, :closed}), do: "Erro no recebimento do request"

  defp get_first_line(request) do
    [linha | _] = String.split(request, "\n")
    linha
  end

  defp log(msg), do: IO.puts("* #{inspect(self())} ===> #{msg} ")
end

# socket options :
# `:binary` - os dados serão tratados como binaries
# `packet: :raw` - os dados nos devem fornecidos totalmente sem manipulação de pacotes
# `active: false` - os dados serão recebidos na chamada da função `:gen_tcp.recv/2`
# `reuseaddr: true` - permite a reutilizaçào de endereço caso dê alguma zebra

# O servidor abre uma porta
#   - cria um socket e fica aguardando (escutando) por um client
#   - no nosso caso o client será o browser
# O client (browser) envia uma requisição de conexão
# O servidor aceita a requisição e cria um client socket
# O client (browser) usa o client socket para enviar uma requisição http
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

#  Servidor.HttpServer.start(2000)
