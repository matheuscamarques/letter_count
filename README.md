# LetterCount

## Projeto para contar letras em determinado texto

```elixir
 def start(_type, _args) do
    children = [
        # Result Armazena os resultados que os workers vão enviar
        LetterCount.Result,
        # File Reader lê um arquivo e guarda esse buffer em uma lista para cada linha
        # [linha1,linha2,linhaN]
        {LetterCount.FileReader , "./file_to_read.txt"},
        # Supervisor Dinamico responsavel por gerenciar os workers que o Gatherer precisa
        LetterCount.WorkerSupervisor,
        # Gerencia quantidade de Workers que vão processar, decide quando o programa para de executar
        # primeiro parametro é quantidade de workers e o segundo a letra que ira pesquisar no texto
        {LetterCount.Gatherer, { 1 , 'p'} }
    ]
    # rode em seu terminal 
    # time mix run --no-halt > dups
    # aumente a quantidade de workers e veja a # diferença
    
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: LetterCount.Supervisor]
    Supervisor.start_link(children, opts)
  end

```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `letter_count` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:letter_count, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/letter_count>.

# letter_count
