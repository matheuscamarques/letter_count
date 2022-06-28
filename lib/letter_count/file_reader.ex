defmodule LetterCount.FileReader do
  use GenServer
  @me FileReader

  def init(file_path) do
    {:ok, contents} = File.read(file_path)
    list_content = contents
                   |> String.split("\n", trim: true)
                   #|> Enum.map(fn line -> String.reverse(line) end)

    {:ok, list_content}
  end

  def handle_call(:next_content,_from,[]) do
    {:reply, [] , []}
  end

  def handle_call(:next_content,_from,[a | b]) do
    {:reply, a , b}
  end


  ## Client
  def start_link(file_path) do
      GenServer.start_link(__MODULE__,file_path, name: @me)
  end

  def get_next_content() do
    GenServer.call(@me, :next_content)
  end

end
