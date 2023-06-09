defmodule Debugger do
  defmacro log(expression) do
    if Application.get_env(:debugger, :log_level) == :debug do
      quote do
        IO.puts("=================")
        IO.inspect(unquote(expression))
        IO.puts("=================")
        unquote(expression)
      end
    else
      expression
    end
  end
end
