require 'test_helper'

module Sl2
  class Sl2::TestingBaseController < Sl2::AuthorizedBaseController
    def index
      render nothing: true
    end
  end
end


class Sl2::AuthorizedBaseControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "Redirect to root_url if user is not SL2" do

    ## SETUP FAKE ROUTES, SO WE REDIRECT NICELY
    Rails.application.routes.draw do
      get 'testing_base' => 'sl2/testing_base#index'
      get 'root' => "some_root_url"
    end


    get '/testing_base'

    assert_equal 302, status
    assert_redirected_to root_url

    Rails.application.routes_reloader.reload!
  end


end
