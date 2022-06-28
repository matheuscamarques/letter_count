defmodule LetterCountTest do
  use ExUnit.Case
  doctest LetterCount

  test "greets the world" do
    assert LetterCount.hello() == :world
  end
end
