defmodule Window.Sized do
  defstruct size: nil, items: :queue.new()

  def add(window = %Window.Sized{size: size, items: items}, item) do
    if :queue.len(items) == size do
      {_, q} = :queue.out_r(items)
      %{ window | items: :queue.in_r(item, q)}
    else
      %{ window | items: :queue.in_r(item, items)}
    end
  end
end
