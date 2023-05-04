defmodule Assertion do
  # {:==, [context: Elixir, import: Kernel], [5, 5]}
  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      # This function will be implemented
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end
