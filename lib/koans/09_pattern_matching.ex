defmodule PatternMatching do
  use Koans

  koan "One matches one" do
    assert match?(1, 1)
  end

  koan "A value can be bound to a variable" do
    a = 1
    assert a == 1
  end

  koan "A variable can be rebound" do
    a = 1
    a = 2
    assert a == 2
  end

  koan "A variable can be pinned to prevent it from being rebounded" do
    a = 1
    assert_raise MatchError, fn() ->
      ^a = 2
    end
  end

  koan "Patterns can be used to pull things apart" do
    [head | tail] = [1, 2, 3, 4]

    assert head == [1]
    assert tail == [2, 3, 4]
  end

  koan "And then put them back together" do
    head = 1
    tail = [2, 3, 4]

    assert [1,2,3,4] == [head | tail]
  end

  koan "Some values can be ignored" do
    [_first, _second, third, _fourth] = [1, 2, 3, 4]

    assert third == ___
  end

  koan "Strings come apart just as easily" do
    "Shopping list: " <> items = "Shopping list: eggs, milk"

    assert items == ___
  end

  koan "Maps support partial pattern matching" do
    %{make: make} = %{type: "car", year: 2016, make: "Honda", color: "black"}

    assert make == ___
  end

  koan "Lists must match exactly" do
    assert_raise ___, fn ->
      [a, b] = [1,2,3]
    end
  end

  koan "The pattern can make assertions about what it expects" do
    assert match?([1, _second, _third], ___)
  end

  def make_noise(%{type: "cat"}), do: "Meow"
  def make_noise(%{type: "dog"}), do: "Woof"
  def make_noise(_anything), do: "Eh?"

  koan "Functions perform pattern matching on their arguments" do
    cat = %{type: "cat"}
    dog = %{type: "dog"}
    snake = %{type: "snake"}

    assert make_noise(cat) == ___
    assert make_noise(dog) == ___
    assert make_noise(snake) == ___
  end

  koan "And they will only run the code that matches the argument" do
    name = fn
      ("duck")  -> "Donald"
      ("mouse") -> "Mickey"
      (_other)  -> "I need a name!"
    end

    assert name.("mouse") == ___
    assert name.("duck") == ___
    assert name.("donkey") == ___
  end

  koan "Errors are shaped differently than successful results" do
    dog = %{type: "dog"}

    result = case Map.fetch(dog, :type) do
      {:ok, value} -> value
      :error -> "not present"
    end

    assert result == ___
  end

  defmodule Animal do
    defstruct [:kind, :name]
  end

  koan "You can pattern match into the fields of a struct" do
    %Animal{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == ___
  end

  koan "Structs will even match with a regular map" do
    %{name: name} = %Animal{kind: "dog", name: "Max"}
    assert name == ___
  end
end
