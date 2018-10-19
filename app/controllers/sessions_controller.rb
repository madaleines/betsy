class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')

    if @merchant
      # User was found in the database
      flash[:success] = "Logged in as returning user #{@merchant.name}"
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      @merchant = Merchant.build_from_github(auth_hash)
      successful_save = @merchant.save
      if successful_save
        flash[:success] = "Logged in Successfully. Welcome #{@merchant.username}"
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new user account: #{@merchant.errors.messages}"
        redirect_to root_path
        return
      end
    end

    # If we get here, we have a valid user instance
    session[:merchant_id] = user.id
    redirect_to root_path
  end

  def logout
    session[:merchant_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
