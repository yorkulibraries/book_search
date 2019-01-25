module Bootstrap
  module TabsHelper
    def bootstrap_tabs(type: "tabs", id: id, classes: "", tab_tag: :ul, &block)
      content = capture(&block)
      content_tag tab_tag, content, id: id, class: "nav nav-#{type} #{classes}"
    end

    def bootstrap_tabs_item(content = nil, href: "#", classes: "",
                        active: false, tab_tag: :ul, disabled: false, &block)

      if block_given?
        content = capture(&block)
      end

      if active
        classes = "#{classes} active"
      end

      common_options = {  class: "nav-link #{classes}", href: href, role: "tab",  data: { toggle: "tab" }}

      if disabled
        common_options.merge!({ aria: { disabled: "true"}, class: "nav-link disabled #{classes}" })
      end


      link = content_tag :a, content, common_options

      if tab_tag == :ul
        item_tag = content_tag :li, link, class: "nav-item"
      else
        item_tag = link
      end

    end

    def bootstrap_tabs_content(id: "", classes: "", &block)
      content = capture(&block)
      content_tag :div, content, class: "tab-content #{classes}", id: id
    end

    def bootstrap_tabs_pane(id = "", classes: "", active: false, &block)
      content = capture(&block)
      if active
        classes = "show active #{classes}"
      end
      content_tag :div, content, id: id, class: "tab-pane fade #{classes}", role: "tabpanel"
    end
  end
end
