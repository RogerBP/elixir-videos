defmodule Servidor.HttpServer do
  def start(port) when port > 1023 do
    log("🎧 ===> Escutando na porta #{port} ..")

    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])

    accept_connection(listen_socket)
  end

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

  defp close_socket(client_socket) do
    log("🚫 <=== Fechando socket...")
    :ok = :gen_tcp.close(client_socket)
  end

  defp send_response({:ok, resp}, client_socket) do
    log("📜 <=== Enviando resposta...")
    :ok = :gen_tcp.send(client_socket, resp)
  end

  defp send_response(resp_error, _client_socket) do
    log("❌ <=== Erro na resposta... #{inspect(resp_error)}")
  end

  defp get_resp({:ok, request}) do
    try do
      {:ok, Servidor.Handler.handle(request)}
    rescue
      e -> {:error, e}
    end
  end

  defp get_resp(received), do: received

  defp get_request(client_socket) do
    log("⏳ <=== Aguardando Requisição ...")

    :gen_tcp.recv(client_socket, 0)
    |> receive_request()
  end

  defp receive_request({:ok, request} = received) do
    [linha | _] = String.split(request, "\n")
    log("📃 <=== Requisição recebida ... #{linha}")
    received
  end

  defp receive_request(received) do
    # {:error, :closed}
    log("❌ <=== Erro na requisição... #{inspect(received)}")
    received
  end

  defp log(msg) do
    dataStr =
      Time.utc_now()
      |> Time.truncate(:second)
      |> Time.to_string()

    IO.puts("#{inspect(self())} ===> #{dataStr} ===> #{msg}")
  end
end

# pid_server = spawn(fn-> Servidor.HttpServer.start(4000) end)
# spawn(fn-> IO.puts("Processo: #{inspect(self())}") end)
# spawn(fn-> :timer.sleep(3000); IO.puts("Processo: #{inspect(self())}") end)
