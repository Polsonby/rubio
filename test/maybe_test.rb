require "test_helper"

class MaybeTest < Minitest::Test
  test "get (Just x) = x" do
    maybe = Rubio::Maybe::JustClass.new(42)
    assert_equal 42, maybe.get!
  end

  test "get Nothing = nil" do
    maybe = Rubio::Maybe::NothingClass.new
    assert_nil maybe.get!
  end

  test "(Just x) >> f = f x" do
    maybe1 = Rubio::Maybe::JustClass.new(42)
    f = ->(x) { Rubio::Maybe::JustClass.new(x / 6) }
    maybe2 = maybe1 >> f

    assert_equal 7, maybe2.get!
  end

  test "Nothing >> f = Nothing" do
    maybe1 = Rubio::Maybe::NothingClass.new
    f = ->(x) { Rubio::Maybe::JustClass.new(x * 2) }
    maybe2 = maybe1 >> f

    assert_instance_of Rubio::Maybe::NothingClass, maybe2
  end

  test "fmap f (Just x) = Just (f x)" do
    maybe1 = Rubio::Maybe::JustClass.new("hello")
    f = ->(x) { x.upcase }
    maybe2 = maybe1.fmap(f)

    assert_equal "HELLO", maybe2.get!
  end

  test "fmap f Nothing = Nothing" do
    maybe1 = Rubio::Maybe::NothingClass.new
    f = ->(x) { x.upcase }
    maybe2 = maybe1.fmap(f)

    assert_instance_of Rubio::Maybe::NothingClass, maybe2
  end

  test "inspecting (Just x) yields a meaningful value" do
    maybe = Rubio::Maybe::JustClass.new(5)
    assert_equal "Just 5", maybe.inspect
  end

  test "inspecting Nothing yields a meaningful value" do
    maybe = Rubio::Maybe::NothingClass.new
    assert_equal "Nothing", maybe.inspect
  end
end
