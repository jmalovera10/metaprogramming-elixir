defmodule Template do
  import Html

  def render_basic() do
    markup do
      tag :table do
        tag :tr do
          for i <- 0..5 do
            tag(:td, do: text("Cell #{i}"))
          end
        end
      end

      tag :div do
        text("Some Nested Content")
      end
    end
  end

  def render_entire_html_tags do
    markup do
      table do
        tr do
          for i <- 0..5 do
            td(do: text("Cell #{i}"))
          end
        end
      end

      div do
        text("Some Nested Content")
      end
    end
  end

  def render_tags_with_attributes do
    markup do
      div id: "main" do
        h1 class: "title" do
          text("Welcome!")
        end
      end

      div class: "row" do
        div do
          p(do: text("Hello!"))
        end
      end
    end
  end
end
