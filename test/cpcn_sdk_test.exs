defmodule CPCNSdkTest do
  use ExUnit.Case
  doctest CPCNSdk

  test "greets the world" do
    assert CPCNSdk.hello() == :world
  end
end
