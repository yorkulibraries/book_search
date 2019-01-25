module Bootstrap
  module CardsHelper

    def bootstrap_card(classes: "", style: "", &block)
      content = capture(&block)
      content_tag :div, content, class: "card #{classes}", style: style
    end

    def bootstrap_card_header(content = nil, classes: "", style: "", &block)

      if block_given?
        content = capture(&block)
      end

      content_tag :div, content, class: "card-header #{classes}", style: style
    end

    def bootstrap_card_body(text = nil, title: nil, subtitle: nil, classes: "", &block)
      title_tag = content_tag :h5, title, class: "card-title"
      subtitle_tag = content_tag :div, subtitle, class: "card-subtitle mb-2 text-muted"
      content = content_tag :p, text, class: "card-text"

      if block_given?
        content = capture(&block)
      end
      content_tag :div, (title_tag + subtitle_tag + content), class: "card-body #{classes}"
    end

    def bootstrap_card_footer(content = nil, classes: "", style: "", &block)
      if block_given?
        content = capture(&block)
      end
      content_tag :div, content, class: "card-footer #{classes}", style: style
    end

  end
end
