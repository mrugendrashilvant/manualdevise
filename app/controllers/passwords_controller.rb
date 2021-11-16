class PasswordsController < ApplicationController
    def forgot 
        if request.post?
            @user = User.find_by_email(params[:email])
            if @user 
                new_password = random_password

                @user.update(:password=>new_password)
                puts "========================================"
                puts new_password
                puts "========================================"
                # UserNotifier.random_password_send(@user, new_password).deliver
                flash[:notice] = "New Password has been sent"
                redirect_to :controller=> :accounts, :action=> :login
            else
                flash[:notice] = "Invalid password"
                render :action=> "forgot-password"
            end
        end

    end

    def random_password
        (0..8).map{65.+(rand(25)).chr}.join
    end

    def reset
		@user = User.find(session[:user])
    
		if request.post?			
			if @user
                
                @user.update(:password=>params[:password])
                # UserNotifier.reset_password_confirmation(@user).deliver
                flash[:notice] = "Your password has been reset"
                redirect_to :controller=> :home, :action=> :index
			
			else
				render :action=>"reset_password"
			end
		else
            puts "not post"
        end
		
	end
end
