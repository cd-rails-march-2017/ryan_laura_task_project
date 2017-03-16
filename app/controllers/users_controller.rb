class UsersController < ApplicationController
  def new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		session[:id] = @user.id
  		redirect_to '/'
  	else 
  		flash[:errors]=@user.errors.full_messages
  		puts @user.errors.full_messages	
  		redirect_to '/users/new'
  	end	
  end

  def login
  end

  def authenticate
  	#render :json => params
  	#return
  	if request.post?
  		user = User.find_by({email:params[:email], password:params[:password]})
  		puts user
  		unless user
  			flash[:notice] = "Username and/or password are not correct"
  			redirect_to '/users/login'
  		else
  			session[:id] = user.id
  			redirect_to '/'
  		end
  	end
  end

  def logout
  	session.clear
  	redirect_to '/users/login'
  end
  
  private
  def user_params
  	params.require(:user).permit(:name,:email,:password)
  end

end
