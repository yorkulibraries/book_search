module Bootstrap
  module CodeHelper
    def bootstrap_code(classes: "border border-primary pb-3", &block)
      content = capture(&block)
      code_tag = content_tag :code, content
      content_tag :pre, code_tag, class: classes
    end
  end
end
