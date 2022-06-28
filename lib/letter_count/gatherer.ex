defmodule LetterCount.Gatherer do
  use GenServer
  @me Gatherer
  # api
  def start_link(worker_count) do
    GenServer.start_link(__MODULE__, worker_count, name: @me)
  end

  def done() do
    GenServer.cast(@me, :done)
  end

  def result(value) do
    GenServer.cast(@me, {:result,value})
  end

  # server
  def init(worker_count) do
    Process.send_after(self(), :kickoff, 0)
    { :ok, worker_count }
  end

  def handle_info(:kickoff, worker_count) do
    {count , letter} = worker_count
    1..count
    |> Enum.each(fn _ -> LetterCount.WorkerSupervisor.add_worker(letter) end)
    { :noreply, worker_count }
  end

  def handle_cast(:done, {1,_} ) do
    report_results()
    System.halt(0)
  end

  def handle_cast(:done, worker_count) do
    {count , letter} = worker_count
    {:noreply,{count - 1 , letter}}
  end

  def handle_cast({:result, value}, worker_count) do
    LetterCount.Result.add_value(value)
    {:noreply, worker_count}
  end

  defp report_results() do
    IO.puts("Results: #{LetterCount.Result.get_result()}\n")
    LetterCount.Result.get_result()
  end
end
