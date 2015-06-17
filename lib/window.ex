defprotocol Windowable do
    def add(window, item)
    def items(window)
end

defmodule Window do
  def sized(size) do
    %Window.Sized{ size: size }
  end

  def sized(id, size, [durable: true]) do
    w = %Window.Sized{ id: id, size: size, durable: true }
    Window.Store.put(w)
    w
  end

  def timed(duration) do
    %Window.Timed{ duration: duration }
  end

  def timed(id, duration, [durable: true]) do
    w = %Window.Timed{ id: id, duration: duration, durable: true }
    Window.Store.put(w)
    w
  end

  def from_id(id) do
    Window.Store.get(id)
  end

  def add(window, item) do
    w = Windowable.add(window, item)
    if w.durable do
      Window.Store.put(w)
    end
    w
  end

  def items(window) do
    Windowable.items(window)
  end
end


defimpl Enumerable, for: [Window.Sized, Window.Timed] do
  def count(window)	do
    {:ok, length(Window.items(window))}
  end

  def member?(window, value)	do
    {:ok, Enum.member?(Window.items(window), value)}
  end

  def reduce(_,      {:halt, acc}, _fun),   do: {:halted, acc}
  def reduce(window, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(window, &1, fun)}
  def reduce(window = %Window.Sized{ items: items}, {:cont, acc}, fun) do
    if :queue.len(items) == 0 do
      {:done, acc}
    else
      h = :queue.head(items)
      reduce(%{ window | items: :queue.tail(items)}, fun.(h, acc), fun)
    end
  end
  def reduce(window = %Window.Timed{ items: items }, {:cont, acc}, fun) do
    if :queue.len(items) == 0 do
      {:done, acc}
    else
      {_, h} = :queue.head(items)
      reduce(%{ window | items: :queue.tail(items)}, fun.(h, acc), fun)
    end
  end
end
