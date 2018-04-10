require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  
  Capybara.register_driver(:headless_chrome) do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless disable-gpu] }
    )

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: capabilities
    )
  end

  # Comment/Uncomment based on which you want to use. 
  # Selenium pops the browser and you can take screenshots etc. 
  # Headless is...well headless browser.
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  driven_by :headless_chrome

  
end
