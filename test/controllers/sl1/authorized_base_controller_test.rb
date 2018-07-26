require 'test_helper'

module Sl1
  class Sl1::TestingBaseController < Sl1::AuthorizedBaseController
    def index
      render nothing: true
    end
  end
end


class Sl1::AuthorizedBaseControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_TWO)
    log_user_in(@user)
  end

  should "Redirect to root_url if user is not SL2" do

    ## SETUP FAKE ROUTES, SO WE REDIRECT NICELY
    Rails.application.routes.draw do
      get 'testing_base' => 'sl1/testing_base#index'
      get 'root' => "some_root_url"
    end


    get '/testing_base'

    assert_equal 302, status
    assert_redirected_to root_url

    Rails.application.routes_reloader.reload!
  end


end
