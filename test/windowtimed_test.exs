defmodule Window.TimedTest do
  use ExUnit.Case

  test "i can create a window" do
    w = %Window.Timed{ duration: 5 }
    assert w.duration == 5
  end

  test "i can add items to window" do
    w =  %Window.Timed{ duration: 5 } |>
         Window.add({1, 1}) |>
         Window.add({2, 1}) |>
         Window.add({3, 1}) |>
         Window.add({4, 1}) |>
         Window.add({5, 1})
    assert Enum.count(Window.items(w)) == 5
  end

  test "a window slides" do
    w = %Window.Timed{ duration: 5 } |>
        Window.add({0, 1}) |>
        Window.add({0, 1}) |>
        Window.add({3, 1}) |>
        Window.add({4, 1}) |>
        Window.add({5, 1}) |>
        Window.add({6, 1})
    assert Enum.count(Window.items(w)) == 4
  end
end
