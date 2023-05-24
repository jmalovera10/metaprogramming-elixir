ExUnit.start()
Code.require_file("translator.exs", __DIR__)

defmodule TranslatorTest do
  use ExUnit.Case

  defmodule Il8n do
    use Translator

    locale("en",
      foo: "bar",
      flash: [
        notice: [
          alert: "Alert!",
          hello: "hello %{first} %{last}!"
        ]
      ],
      users: [
        title: "Users",
        profile: [
          title: "Profiles"
        ]
      ]
    )

    locale("fr",
      flash: [
        notice: [
          hello: "salut %{first} %{last}!"
        ]
      ]
    )
  end

  test "it recursively walks translations tree" do
    assert Il8n.t("en", "users.title") == "Users"
    assert Il8n.t("en", "users.profile.title") == "Profiles"
  end

  test "it handles translation at root level" do
    assert Il8n.t("en", "foo") == "bar"
  end

  # This test should only be used only for isolated, complex cases like the recursive compile function
  test "compile/1 generates catch-all t/3 functions" do
    assert Translator.compile([]) |> Macro.to_string() ==
             String.strip(~S"""
             def t(locale, path, binding \\ [])
             []

             def t(_locale, _path, _bindings) do
               {:error, :no_translation}
             end
             """)
  end

  test "compile/1 generates t/3 functions from each locale" do
    locales = [{"en", [foo: "bar", bar: "%{baz}"]}]

    assert Translator.compile(locales) |> Macro.to_string() ==
             String.strip(~S"""
             def t(locale, path, binding \\ [])

             [
               [
                 def t("en", "foo", bindings) do
                   "" <> "bar"
                 end,
                 def t("en", "bar", bindings) do
                   (("" <> "") <> to_string(Dict.fetch!(bindings, :baz))) <> ""
                 end
               ]
             ]

             def t(_locale, _path, _bindings) do
               {:error, :no_translation}
             end
             """)
  end
end
