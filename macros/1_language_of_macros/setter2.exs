# By using var we are able to override hygiene to rebind name to a new value
defmodule Setter do
  defmacro bind_name(string) do
    quote do
      var!(name) = unquote(string)
    end
  end
end
