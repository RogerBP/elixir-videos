# Run as: iex --dot-iex path/to/notebook.exs

# Title: ELIXIR - VIDEO - 008

# ── Section ──

defmodule Servidor.Conv do
  defstruct method: "", path: "", protocol: "", resp_body: "", status: nil
end

# conv = %Servidor.Conv{}
conv = %Servidor.Conv{method: "GET", path: "/books"}
map = %{name: "Roger"}
# conv = %Servidor.Conv{name: "Roger"}

# IO.inspect(map.name)
# IO.inspect(map[:name])
# IO.inspect(map[:type])
IO.inspect(conv.method)
# IO.inspect(conv.type)
# IO.inspect(conv[:method])
# IO.inspect(conv[:type])

# "Atualizar" o struct igual ao map
# conv = %{conv | path: "/games"}

# Pattern matching
# %Servidor.Conv{method: "GET"} = conv
# %Servidor.Conv{method: "POST"} = conv
# %Servidor.Conv{method: m} = conv
# IO.inspect m

# is_map(conv)
# is_map(%Servidor.Conv{})
# %{method: "GET"} = conv
# %{method: "POST"} = conv
# %{method: m} = conv
# IO.inspect m
#
# %Servidor.Conv{method: "POST"} = %Servidor.Conv{method: "POST"}
# %{method: "POST"} = %{method: "POST"}
# %{method: "POST"} = %Servidor.Conv{method: "POST"}
# %Servidor.Conv{method: "POST"} = %{method: "POST"}
