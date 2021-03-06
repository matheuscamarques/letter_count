defmodule LetterCount.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
        LetterCount.Result,
        {LetterCount.FileReader , "./file_to_read.txt"},
        LetterCount.WorkerSupervisor,
        {LetterCount.Gatherer, { 1 , 'p'} }
    ]
    # time mix run --no-halt > dups

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: LetterCount.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
