defmodule Assertion do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :tests, accumulate: true)

      def run do
        IO.puts("Running the tests (#{inspect(@tests)})")
      end
    end
  end

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    # Generate lines of code within the callers context. Accumulate the test_func reference and
    # description in the @tests module attribute
    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end
end
