defmodule DockexirTest do
  use ExUnit.Case
  doctest Dockexir

  test "the truth" do
    {:ok, result} = Dockexir.HTTP.get("/images/json")
    IO.inspect Poison.decode!(result)
  end
end
