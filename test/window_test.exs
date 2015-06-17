defmodule WindowTest do
  use ExUnit.Case
  doctest Window

  test "i can create a sized window" do
      w = Window.sized(5)
      assert w.size == 5
  end

  test "i can create a durable sized window" do
      w = Window.sized(5, durable: true)
      assert w.size == 5
  end

  test "i can create a timed window" do
      w = Window.timed(30)
      assert w.duration == 30
  end

  test "i can create a durable timed window" do
      w = Window.timed(30, durable: true)
      assert w.duration == 30
  end

  test "a sized window slides" do
    w = Window.sized(5) |>
        Window.add(1) |>
        Window.add(2) |>
        Window.add(3) |>
        Window.add(4) |>
        Window.add(5) |>
        Window.add(6)
    assert Enum.count(w) == 5
  end

  test "i can recreate a durable sized window" do
    w = Window.sized(5, durable: true) |>
        Window.add(1) |>
        Window.add(2) |>
        Window.add(3) |>
        Window.add(4) |>
        Window.add(5) |>
        Window.add(6)
    w1 = Window.from_id(w.id)
    assert w1.size == 5
    assert Enum.count(w1) == 5
  end

  test "a timed window slides" do
    w = Window.timed(5) |>
        Window.add({0, 1}) |>
        Window.add({0, 1}) |>
        Window.add({3, 1}) |>
        Window.add({4, 1}) |>
        Window.add({5, 1}) |>
        Window.add({6, 1})
    assert Enum.sum(w) == 4
  end

  test "i can recreate a durable timed window" do
    w = Window.timed(5) |>
        Window.add({0, 1}) |>
        Window.add({0, 1}) |>
        Window.add({3, 1}) |>
        Window.add({4, 1}) |>
        Window.add({5, 1}) |>
        Window.add({6, 1})
    w1 = Window.from_id(w.id)
    assert w1.duration == 5
    assert Enum.count(w1) == 6
  end
end
