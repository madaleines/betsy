require "test_helper"

describe SessionsController do
  it " redirects to home page and displays a successful flash message when logging in Github is successful" do

    #Arrange
    # Make sure that for some existing user, everything is configured

    merchant_one = merchants(:one)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( merchant_one ) )


    #Act
    # Simulating logging in with github being successful (given the OmniAUth hash above)
    get auth_callback_path(:github)

    # Assert
    #Check that it redirects
    must_redirect_to home_path
    expect(session[:merchant_id]).must_equal merchant_one.id
  end
end
