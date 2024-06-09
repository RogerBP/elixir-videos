defmodule Servidor.Handler do
  def handle(request) do
    IO.inspect(request, label: "===> handle(request)")

    request
    |> parse
    |> route
    |> format_response
  end

  def parse(request) do
    IO.inspect(request, label: "===> parse(request)")

    [method, path, protocol] =
      request
      |> String.replace("\r\n", "\n")
      |> String.split("\n")
      |> List.first()
      |> String.split()

    %{method: method, path: path, protocol: protocol, resp_body: ""}
  end

  def route(conv) do
    IO.inspect(conv, label: "===> route(conv)")

    %{
      conv
      | resp_body: """
        O homem que calculava, Malba Tahan
        StarWars - Herdeiros do Império, Timothy Zhan
        O Silmarilion - J.R.R.Tolkien
        """
    }
  end

  def format_response(conv) do
    IO.inspect(conv, label: "===> format_response(conv)")
    body = String.replace(conv.resp_body, "\r\n", "\n")

    """
    #{conv.protocol} 200 OK
    Content-Type: text/html
    Content-Length: #{String.length(body)}

    #{body}
    """
  end
end
