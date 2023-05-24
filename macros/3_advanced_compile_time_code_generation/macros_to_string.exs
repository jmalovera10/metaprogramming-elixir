def compile(translations) do
   translations_ast = for {locale, mappings} <- translations do
   deftranslations(locale, "", mappings)
   end


   final_ast = quote do
   def t(locale, path, binding \\ [])
   unquote(translations_ast)
   def t(_locale, _path, _bindings), do: {:error, :no_translation}
   end

   IO.puts Macro.to_string(final_ast)
   final_ast
end
