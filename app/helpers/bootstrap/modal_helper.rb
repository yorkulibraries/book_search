module Bootstrap
  module ModalHelper
    def bootstrap_modal(id: "", classes: "", size:"", tabindex: "-1", show: false, style: "", &block)
      content = capture(&block)
      m_classes = "modal fade"

      if show
        m_classes = "modal"
      end

      options = { id: id, class: m_classes, style: style, tabindex: tabindex, aria: { hidden: true}, role: "dialog" }

      m_content_tag = content_tag :div, content, class: "modal-content #{classes}"
      m_dialog_tag = content_tag :div, m_content_tag, class: "modal-dialog #{size}", role: "document"
      m_parent_tag = content_tag :div, m_dialog_tag, options
    end

    def bootstrap_modal_body(text = nil, classes: "", style: "", &block)
      if block_given?
        content = capture(&block)
      else
        content = content_tag :p, text, class: "mb-0"
      end

      content_tag :div, content, class: "modal-body #{classes}", style: style
    end

    def bootstrap_modal_header(title = nil, classes: "", style: "", dismissable: true, &block)
      if block_given?
        content = capture(&block)
      else
        content = content_tag :h5, title, class: "modal-title"
      end

      if dismissable
        span_tag = content_tag :span, "&times;".html_safe, aria_hidden: true
        dismiss_div = content_tag(:button,
                                 span_tag,
                                 class: "close",
                                 data: { dismiss: "modal" },
                                 aria_label: "Close",
                                 type: "button")

        dismissable_classes = "alert-dismissible fade show"

        content = content.html_safe + dismiss_div
      end


      content_tag :div, content, class: "modal-header #{classes}", style: style
    end

    def bootstrap_modal_footer(text = nil, classes: "", style: "", &block)
      if block_given?
        content = capture(&block)
      else
        content = content_tag :p, text, class: "mb-0"
      end

      content_tag :div, content, class: "modal-footer #{classes}", style: style
    end
  
  end
end
