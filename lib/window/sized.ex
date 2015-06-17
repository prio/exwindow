defmodule Window.Sized do
  defstruct id: nil, size: nil, items: :queue.new(), durable: false
end

defimpl Windowable, for: Window.Sized do
  def add(window = %Window.Sized{size: size, items: items}, item) do
    if :queue.len(items) == size do
      {_, q} = :queue.out_r(items)
      %{ window | items: :queue.in_r(item, q)}
    else
      %{ window | items: :queue.in_r(item, items)}
    end
  end

  def items(window) do
    :queue.to_list(window.items)
  end
end
