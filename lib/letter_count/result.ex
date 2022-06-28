defmodule LetterCount.Result do
  use GenServer

  @me __MODULE__

  # API

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def add_value(value) do
    GenServer.cast(@me, {:add, value})
  end

  def get_result() do
    GenServer.call(@me, :get)
  end
  # Server
  def init(:no_args) do
    {:ok, 0}
  end

  def handle_cast({:add,value},state) do
    {:noreply, state + value}
  end

  def handle_call(:get,_from ,state) do
    {:reply, state , state}
  end
end
