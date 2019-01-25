module Bootstrap
  module AlertHelper
    def bootstrap_alert (content = nil, type: "secondary", dismissable: false, &block)
      if dismissable
        span_tag = content_tag :span, "&times;".html_safe, aria_hidden: true
        dismiss_div = content_tag(:button,
                                 span_tag,
                                 class: "close",
                                 data: {dismiss: "alert"},
                                 aria_label: "Close",
                                 type: "button")

        dismissable_classes = "alert-dismissible fade show"
      end

      classes = "alert alert-#{type} #{dismissable_classes}"

      if block_given?
        content = capture(&block)
      end

      if dismissable
        content_tag :div, content.html_safe + dismiss_div, class: classes, role: "alert"
      else
        content_tag :div, content, class: classes, role: "alert"
      end

    end

  end
end
