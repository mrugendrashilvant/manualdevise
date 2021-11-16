class AccountsController < ApplicationController
    # before_save :encrypt_password

    def login 
        if request.post?
            @user = User.authenticate(params[:email], params[:password])
                if @user
                    session[:user] = @user.id 
                    flash[:notice] = "Logged in Successfully!"
                    redirect_to :controller=>:home, :action=>:index
                else
                    render :login
                end
        end
    end

    def logout
        session[:user] = nil 
        flash[:notice] = "Logged out!"
        redirect_to :action=>:login
    end

    def signup
        if request.post?
            @user = User.new(user_params)
            if @user.save
                #trigger Action mailer
                flash[:notice] = "Account created"
                redirect_to :login
            else
                render :signup 
            end
        end
    end

    def user_params
        params.permit(:f_name, :l_name, :email, :date_of_birth, :mobile, :password, :hashed_password)
    end

end
