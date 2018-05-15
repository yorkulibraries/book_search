module LayoutHelper

  def page_title(title)
    content_for(:page_title) { h(title.to_s) }
  end

  def page_notice_html(&block)
    content_for(:page_notice_html) do
      yield block
    end
  end


  def dev_navbar_helper    
  end
end
