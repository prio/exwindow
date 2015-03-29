defmodule Window.SizedTest do
  use ExUnit.Case

  test "i can create a window" do
    w = %Window.Sized{ size: 5 }
    assert w.size == 5
  end

  test "i can add units to window" do
    w =  %Window.Sized{ size: 5 } |>
         Window.Sized.add(1) |>
         Window.Sized.add(2) |>
         Window.Sized.add(3) |>
         Window.Sized.add(4) |>
         Window.Sized.add(5)
    assert :queue.len(w.items) == 5
  end

  test "a window slides" do
    w = %Window.Sized{ size: 5 } |>
         Window.Sized.add(1) |>
         Window.Sized.add(2) |>
         Window.Sized.add(3) |>
         Window.Sized.add(4) |>
         Window.Sized.add(5) |>
         Window.Sized.add(6)
    assert :queue.len(w.items) == 5
  end
end
