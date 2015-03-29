defmodule Window.TimedTest do
  use ExUnit.Case

  test "i can create a window" do
    w = %Window.Timed{ duration: 5 }
    assert w.duration == 5
  end

  test "i can add units to window" do
    w =  %Window.Timed{ duration: 5 } |>
         Window.Timed.add({1, 1}) |>
         Window.Timed.add({2, 1}) |>
         Window.Timed.add({3, 1}) |>
         Window.Timed.add({4, 1}) |>
         Window.Timed.add({5, 1})
    assert :queue.len(w.items) == 5
  end

  test "a window slides" do
    w = %Window.Timed{ duration: 5 } |>
        Window.Timed.add({0, 1}) |>
        Window.Timed.add({0, 1}) |>
        Window.Timed.add({3, 1}) |>
        Window.Timed.add({4, 1}) |>
        Window.Timed.add({5, 1}) |>
        Window.Timed.add({6, 1})
    assert :queue.len(w.items) == 4
  end
end
