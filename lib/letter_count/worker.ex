defmodule LetterCount.Worker do
  use GenServer, restart: :transient

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    Process.send_after(self(), {:start_content,state}, 0)
    {:ok, nil}
  end

  def handle_info({:start_content, state}, _ ) do
     LetterCount.FileReader.get_next_content()
                  |> make_result(state)
  end

  defp make_result([],_) do
    # IO.puts("chegou aqui vazio")
    LetterCount.Gatherer.done()
    {:stop, :normal, []}
  end

  defp make_result(value,state) do
    # IO.puts("chegou aqui vazio #{inspect value}")
    value
         |> String.to_charlist
         |> count_ocorrency(state)
         |>  LetterCount.Gatherer.result

    send(self(), {:start_content, state})
    {:noreply, nil}
  end

  def count_ocorrency(charlist,letter)  do
    count_ocorrency(charlist,letter,0)
  end

  def count_ocorrency([],_,count) do
    count
  end
  def count_ocorrency([a | b],letter, count) when [a] == letter do
    count_ocorrency(b,letter,count + 1)
  end

  def count_ocorrency([a | b],letter, count) when [a] != letter do
    count_ocorrency(b,letter,count)
  end





end
