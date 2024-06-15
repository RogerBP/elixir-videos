# Run as: iex --dot-iex path/to/notebook.exs

# Title: ELIXIR - VIDEO - 006

# ── Section ──

# nil / false

a = nil
b = false
c = true
d = "ABC"
e = 0.5
f = %{a: 1, b: 2, c: 3}
g = {:ok, "OK"}

# ── if ──

# if (g == "45") do
#   "verdadeiro"
# end

# if (c) do
#   "verdadeiro"
# else
#   "falso"
# end

if a do
  "a verdadeiro"
else
  if b do
    "b verdadeiro"
  else
    "falso"
  end
end

# ── unless ──

# if (!a) do
#   "false"
# end

# # unless (d) do
# #   "false"
# # end

# unless (a) do
#   "falso"
# else
#   "verdadeiro"
# end

# unless (a) do
#   "a falso"
# else
#   unless (b) do
#     "b falso"
#   else
#     "verdadeiro"
#   end
# end

# ── case ──

msg = "outra mensagem"

a = nil
b = false
c = true
d = "ABC"
e = 0.5
f = %{a: 1, b: 2, c: 3}
g = {:ok, "OK"}

case f do
  nil -> "dado é nil"
  false -> "dado é false"
  true -> "dado é true"
  "ABC" -> "dado é ABC"
  0.5 -> "dado é 0.5"
  %{a: b} -> "dado é %{ map: #{b} }"
  {:ok} -> "dado é tupla"
  ^msg -> "esta é a mensagem: #{msg} "
  _ -> "qq coisa"
end

conv = %{path: "/books/1", protocol: "HTTP/1.1", method: "GET", resp_body: ""}

%{path: "/books/1"} = conv

"/books/" <> i = "/books/1"
