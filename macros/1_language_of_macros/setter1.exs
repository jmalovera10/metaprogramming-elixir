# The name variable is not clobbered by the macro hygiene protected the caller's scope
defmodule Setter do
  defmacro bind_name(string) do
    quote do
      name = unquote(string)
    end
  end
end
