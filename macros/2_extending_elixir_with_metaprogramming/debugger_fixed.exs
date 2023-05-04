defmodule Debugger do
  defmacro log(expression) do
    if Application.get_env(:debugger, :log_level) == :debug do
      # By using bind_quoted we prevent double evaluation of this code
      quote bind_quoted: [expression: expression] do
        IO.puts("=================")
        IO.inspect(expression)
        IO.puts("=================")
        expression
      end
    else
      expression
    end
  end
end
