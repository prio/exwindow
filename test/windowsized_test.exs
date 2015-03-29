defmodule Window.SizedTest do
  use ExUnit.Case

  test "i can create a window" do
    w = %Window.Sized{ size: 5 }
    assert w.size == 5
  end

  test "i can add items to window" do
    w =  %Window.Sized{ size: 5 } |>
         Window.add(1) |>
         Window.add(2) |>
         Window.add(3) |>
         Window.add(4) |>
         Window.add(5)
    assert Enum.count(Window.items(w)) == 5
  end

  test "a window slides" do
    w = %Window.Sized{ size: 5 } |>
         Window.add(1) |>
         Window.add(2) |>
         Window.add(3) |>
         Window.add(4) |>
         Window.add(5) |>
         Window.add(6)
    assert Enum.count(Window.items(w)) == 5
  end
end
