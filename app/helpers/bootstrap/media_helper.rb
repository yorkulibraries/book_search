module Bootstrap
  module MediaHelper

    def bootstrap_media(classes: "", id: "", tag: :div, &block )
      content = capture(&block)
      content_tag tag, content, class: "media #{classes}", id: id
    end

    def bootstrap_media_body(title: nil, body: nil, title_classes: "", classes: "", style: "", id: "", &block)
      if block_given?
        content = capture(&block)
        content_tag(:div, content, class: "media-body #{classes}", id: id)     
      else
        title_tag = content_tag(:h5, title, class: "mt-0 #{title_classes}")
        content_tag(:div, title_tag + body.html_safe, class: "media-body #{classes}", id: id)
      end
    end

    def bootstrap_media_image(src: nil, align: "top", classes: "", &block)
      if block_given?
        yield block
      else
        case align
        when "bottom"
          align_class = "align-self-end"
        when "middle"
          align_class = "align-self-center"
        else
          align_class = "align-self-start"
        end
        content_tag(:img, img_src, class: "#{align_class} mr-3 #{classes}")
      end
    end

    def svg_placeholder(color: "#007aff", width: 20, height: 20, classes: "rounded mr-2")
      rectangle = content_tag :rect, "", fill: color, width: "100%", height: "100%"
      options = { class: classes, width: width, height: height,
                xmlns: "http://www.w3.org/2000/svg", preserveAspectRation: "xMidYMid slice",
                focusable: "false", role: "img"
                }

      content_tag :svg, rectangle, options
    end
  end
end
