# Run as: iex --dot-iex path/to/notebook.exs

# Title: ELIXIR - VIDEO - 004 - Atom / List / Tuple / Map

# ── Atom ──

# Atomo => Constante cujo valor é ele mesmo

# :abc
# :abc_def_@ghi
# :"roger b. pessoa"

# Átomos especiais

# :true
# :false
# :nil

# true
# false
# nil

# true == :true
# false == :false
# nil == :nil

# ── List ──

# List => Encadeamento / Um ítem aponta para o próximo / Tamanho variável

lista_1 = [1, 2, 3]
lista_2 = [:a, true, "c", 4]

# [4] ++ lista_1
# lista_1 ++ [4]
# lista_1 ++ lista_2
# lista_1 -- [3]

length(lista_1)

# ── Tuple ──

# Tupla / Semelhante a List / Tamanho Fixo

a = {:a, 1, "cd"}
# elem(a, 0)
# put_elem(a, 1, :novo_elemento)
# tuple_size(a)

# b = {:a, 1, "Roger", {:nome, :ok, :true}, [1, 2, 3]}
# c = Tuple.append(b, [4, 5, 6]) # Copia as referências

# ── Map ──

# Map / Key-Value / JSON

a = %{"one" => 1, 2 => "two", :three => 3}
# b = %{3 => "four", "one" => :two}
# c = %{:nome => "Roger", canal: "Sabe contar"}

# a["one"]
# a[2]
# a[:three]
# a[3]
# a.three
# a.3
# Map.get(a, :three)
# Map.get(a, :four)
# map_size(a)

# Map "update"
# %{a | three: 4}
# %{a | four: 4}

# ── IO.puts ──

# IO.puts()
s = "string"
a = :atomo
ln = [65, 66, 67, 68]
ls = ["abc", "def", "ghi"]
lx = ln ++ ls
la = [:a, :b, :c]
t = {:ok, "tudo certo!"}
m = %{a: 1, b: 2, c: 3}

IO.puts(s)
# IO.puts(a)
# IO.puts(ln)
# IO.puts(ls)
# IO.puts(lx)
# IO.puts(a)
# IO.puts(t)
# IO.puts(m)

# ── IO.inspect ──

# IO.inspect()

# IO.inspect(s)
# IO.inspect(a)
# IO.inspect(ln)
# IO.inspect(ls)
# IO.inspect(lx)
# IO.inspect(a)
# IO.inspect(t)
# IO.inspect(m)

# ── Shortcuts ──

# t = [{:a, 1}, {:b, 2}, {:c, 3}]
# t = [a: 1, b: 2, c: 3]
# Enum.at(t, 0)

# IO.inspect(m, [{:label, "==> MAP <=="}])
# IO.inspect(m, [label: "==> MAP <=="])
# IO.inspect(m, label: "==> MAP <==")
# IO.inspect m, label: "==> MAP <=="

# m
# |> IO.inspect([{:label, "==> MAP <=="}])
# |> IO.inspect([label: "==> MAP <=="])
# |> IO.inspect(label: "==> MAP <==")
# # |> IO.inspect label: "==> MAP <=="
