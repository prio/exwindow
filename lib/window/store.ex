defmodule Window.Store do
  use GenServer

  # external API
  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    #Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def put(window) do
    GenServer.cast(__MODULE__, {:put, window})
  end

  # GenServer implementation
  def init(:ok) do
    {:ok, Map.new}
  end

  def handle_call({:get, id}, _from, store) do
    #{:ok, window} = Agent.get(store, &Map.get(&1, id))
    window = Map.get(store, id)
    {:reply, window, store}
  end

  def handle_cast({:put, window}, store) do
    #Agent.update(store, &Map.put(&1, window.id, window))
    store = Map.put(store, window.id, window)
    {:noreply, store}
  end
end
