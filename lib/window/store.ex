defmodule Window.Store do
  use GenServer

  # external API
  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def put(window) do
    GenServer.cast(__MODULE__, {:put, window})
  end

  # GenServer implementation
  def init(:ok) do
    {:ok, HashDict.new}
  end

  def handle_call({:get, id}, store) do
    #{:ok, window} = Agent.get(store, &HashDict.get(&1, id))
    window = HashDict.get(store, id)
    {:reply, window, store}
  end

  def handle_cast({:put, window}, store) do
    #Agent.update(store, &HashDict.put(&1, window.id, window))
    HashDict.put(store, window.id, window)
    {:noreply, store}
  end
end
