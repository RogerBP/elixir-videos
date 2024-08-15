# Run as: iex --dot-iex path/to/notebook.exs

# Title: ELIXIR-VIDEO-009

# ── Request ──

request =
  """
  POST /books HTTP/1.1
  Host: example.com
  User-Agent: Browser/1.0
  Accept: */*
  Content-Type: application/x-www-form-urlencoded
  Content-Length: 21

  name=Os primeiros casos de Poirot&author=Agatha Christie
  """

# ── Conv Struct ──

defmodule Servidor.Conv do
  # defstruct method: "",
  #           path: "",
  #           protocol: "",
  #           resp_body: "",
  #           status: nil,

  # defstruct method: "",
  #           path: "",
  #           protocol: "",
  #           resp_body: "",
  #           status: nil,
  #           params: nil

  defstruct method: "",
            path: "",
            protocol: "",
            resp_body: "",
            status: nil,
            params: nil,
            headers: nil
end

# ── Parse ──

[method, path, protocol] =
  request
  |> String.replace("\r\n", "\n")
  |> String.split("\n")
  |> List.first()
  |> String.split()

%Servidor.Conv{
  method: method,
  path: path,
  protocol: protocol,
  status: 200
}

# Resultado
# %Servidor.Conv{
#   method: "POST",
#   path: "/books",
#   protocol: "HTTP/1.1",
#   resp_body: "",
#   status: 200
# }

# Resultado no App

# ── Parse: Request / Body ──

# Separar o Request do Body
# Split em um item na lista para cada linha da string

request
|> String.replace("\r\n", "\n")
|> String.split("\n")

# Resultado
# O body é separado do header por 2 saltos de linha
[
  "POST /books HTTP/1.1",
  "Host: example.com",
  "User-Agent: Browser/1.0",
  "Accept: */*",
  "Content-Type: application/x-www-form-urlencoded",
  "Content-Length: 21",
  "",
  "name=Os primeiros casos de Poirot&author=Agatha Christie",
  ""
]

# Split em 2 itens item na lista
request
|> String.replace("\r\n", "\n")
|> String.split("\n\n")

# Resultado (header / body)
[
  "POST /books HTTP/1.1\nHost: example.com\nUser-Agent: Browser/1.0\nAccept: */*\nContent-Type: application/x-www-form-urlencoded\nContent-Length: 21",
  "name=Os primeiros casos de Poirot&author=Agatha Christie\n"
]

# Separa header / body
[header_lines, params_line] =
  request
  |> String.replace("\r\n", "\n")
  |> String.split("\n\n")

IO.puts("== HEADER ==")
IO.puts(header_lines)

IO.puts("")
IO.puts("== PARAMS ==")
IO.puts(params_line)

# A partir do header_lines nosso Parse continua funcionando
[method, path, protocol] =
  header_lines
  |> String.split("\n")
  |> List.first()
  |> String.split()

%Servidor.Conv{
  method: method,
  path: path,
  protocol: protocol,
  status: 200
}

# Adicionar o field "params" em %Servidor.Conv antes de prosseguir

# %Servidor.Conv{
#   method: method,
#   path: path,
#   protocol: protocol,
#   status: 200,
#   params: params_line
# }

# Tranferir resultados para o código

# ── Parse: Body => Params => Map ──

# Transformar o params_line em um MAP
params = URI.decode_query(params_line)

# Limpando salto de linha
params = URI.decode_query(String.trim(params_line))

# Macete pra transformar strings em atomos
# Pq não fazer nesse caso
# for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}

# Tranferir para o código e criar o Resp Body baseado nos "params"

# ── Content-Type ──

# application/x-www-form-urlencoded
# multipart/form-data
# application/json
# application/xml
# text/plain
# application/octet-stream
# application/graphql
# application/pdf
# application/javascript
# application/zip
# application/vnd.api+json

# ── Parse: TopLine / Headers ──

# header_lines no momento
header_lines

# "POST /books HTTP/1.1\nHost: example.com\nUser-Agent: Browser/1.0\nAccept: */*\nContent-Type: application/x-www-form-urlencoded\nContent-Length: 21"

# Tranformação atual despreza os headers
header_lines
  |> String.split("\n")
  |> List.first()
  |> String.split()

# Conteúdo de todas as linhas
top_lines =
  header_lines
  |> String.split("\n")

# Resultado em linhas
[
  "POST /books HTTP/1.1",
  "Host: example.com",
  "User-Agent: Browser/1.0",
  "Accept: */*",
  "Content-Type: application/x-www-form-urlencoded",
  "Content-Length: 21"
]

# ── List / Head / Tail / Cons Operator / Função: inspect ──

# Como dividir em top_line (primeira linha) e headers_lines (restante)
lista = [1, 2, 3, 4, 5]
[a, b, c, d, e] = lista
IO.puts("#{a}, #{b}, #{c}, #{d}, #{e}")

# Conceito de Head e Tail de uma List / Cons Operator "|"
[head | tail] = lista
# IO.puts("head: #{head} / tail: #{tail}")
IO.puts("head: #{head} / tail: #{inspect(tail)}")


# Usando o cons operator em top_lines
[top_line | headers_lines] = top_lines

IO.puts(inspect(top_line))
IO.puts(inspect(headers_lines))


# Resultado
# "POST /books HTTP/1.1"

[
  "Host: example.com",
  "User-Agent: Browser/1.0",
  "Accept: */*",
  "Content-Type: application/x-www-form-urlencoded",
  "Content-Length: 21"
]

#  A partir do novo header nosso Parse continua funcionando

[method, path, protocol] =
  top_line
  |> String.split()

# %Servidor.Conv{
#   method: method,
#   path: path,
#   protocol: protocol,
#   status: 200,
#   params: params
# }

# Adicionar o field "headers" em %Servidor.Conv antes de prosseguir
%Servidor.Conv{
  method: method,
  path: path,
  protocol: protocol,
  status: 200,
  params: params,
  headers: headers_lines
}

# Transferir headers para o código

# ── Parse: Headers => Map ──

# - Transformar os headers num Map
headers_lines
# [
#   "Host: example.com",
#   "User-Agent: Browser/1.0",
#   "Accept: */*",
#   "Content-Type: application/x-www-form-urlencoded",
#   "Content-Length: 21"
# ]

# Conceito de Head e Tail de uma List / Cons Operator "|"
lista = [1, 2, 3, 4, 5]

[head | tail] = lista
IO.puts("head: #{head} / tail: #{inspect(tail)}")
# [head | tail] = tail
# IO.puts("head: #{head} / tail: #{inspect(tail)}")
# [head | tail] = tail
# IO.puts("head: #{head} / tail: #{inspect(tail)}")
# [head | tail] = tail
# IO.puts("head: #{head} / tail: #{inspect(tail)}")
# [head | tail] = tail
# IO.puts("head: #{head} / tail: #{inspect(tail)}")
# [head | tail] = tail
# IO.puts("head: #{head} / tail: #{inspect(tail)}")


# Loop recursivo pela lista
defmodule ListaLoop do
  def loop(lista) do
    IO.puts("lista: #{inspect(lista)}")

    # [head | tail] = lista
    # IO.puts("head: #{head} / tail: #{inspect(tail)}")
  end

  # def loop([head | tail]) do
  #   IO.puts("head: #{head} / tail: #{inspect(tail)}")
  #   loop(tail)
  # end

  # def loop([]), do: IO.puts("fim")
end

ListaLoop.loop(lista)
ListaLoop.loop(12345)
ListaLoop.loop("Roger")
# ListaLoop.loop(headers_lines)

# headers_lines
# [
#   "Host: example.com",
#   "User-Agent: Browser/1.0",
#   "Accept: */*",
#   "Content-Type: application/x-www-form-urlencoded",
#   "Content-Length: 21"
# ]

head_list = String.split("Host: example.com", ": ")

# [key, value] = head_list
# IO.puts("key: #{key} / value: #{inspect(value)}")
# %{key => value}
# header = Map.put(%{}, key, value)

headers_lines

defmodule Utils do
  def list_to_map([head | tail]) do
    IO.puts("head: #{head} / tail: #{inspect(tail)}")
    list_to_map(tail)
  end

  def list_to_map([]), do: "fim"

  # def list_to_map([head | tail], map) do
  #   IO.puts("head: #{head} / tail: #{inspect(tail)}")
  #   head_list = String.split(head, ": ")
  #   [key, value] = head_list
  #   new_map = Map.put(map, key, value)
  #   list_to_map(tail, new_map)
  # end

  # def list_to_map([], map), do: map
end

Utils.list_to_map(headers_lines)
# Utils.list_to_map(headers_lines, %{})



# TAIL CALL OPTIMIZATION
# Tranferir para o código
