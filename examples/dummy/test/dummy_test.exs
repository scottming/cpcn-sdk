defmodule DummyTest do
  use ExUnit.Case
  doctest Dummy

  test "greets the world" do
    assert Dummy.hello() == :world
  end

  @scottming_signature "3e2e9903bbe853b3c38eb81f54f1584bfb135cd4d2c567a105f0e24d7ecd4dd86791040624512d3a07011e4ba0548bf8752540e1497e66c07a033655acfd95e5f1a061537d1ed30925b234b8af3662b10802482b06c155f0e544c7998334a030babbb333fdcbbd4d5461222b1de521e484634c90c9718db2d79de6a076bfd7923cc7cdd23dd2a8b48be0ee2c3bcaafcc705cb40cb1f1b3fe9f811eaba939228358e12886086e5968d7a0d57da3fbcd5fd34144de8bf6496e03edb516e22f0cc4df8387fc6d8352096a8cfa81539b9a99d7354ef4dad1d9e4eeff69df4f914b1c8966c371cf36ff6832793e8da518009059e38dc1be2925341dde7a875970dbb3778f18a505439b0c64fbbd1f4c65e6f8047ce98fd295bb58b75755b14f9cd2d421e1b6ab37254acca5b323b3365e0e93de25331b975912f6b22f5808babe46ed5cde5dfc5a21d34c020345ca8fdac2e687d945c609758c93fc04bd9e31ced6b101853e53030a2453d590da806d3d35eff331735317b4be88685162fb71bcba4d"

  test "sign a message" do
    message = "scottming"
    assert CPCNSdk.sign(message) == @scottming_signature
  end

  test "verify a message" do
    message = "scottming"
    assert CPCNSdk.verify?(message, @scottming_signature)
  end
end
