require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_bot'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...

  include FactoryBot::Syntax::Methods
  include ActionMailer::TestHelper
  include ActiveJob::TestHelper
end


class ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  def log_user_in(user)
    get login_url, headers: { "HTTP_PYORK_USER" => user.uid }
  end

  def get_instance_var(what)
    controller.instance_variable_get("@#{what.to_s}")
  rescue NameError => e
    return nil
  end

  def assert_template(which)

  end

end
