class TodosController < ApplicationController
  def index
  	@user = User.find(session[:id])
  	if !@user
  		redirect_to '/users/login'
  	end
  	if session[:hide]
  		@tasks = Todo.where('checkbox = ?', true)
  	else
  		@tasks = Todo.where(user_id:session[:id])
  	end
  end

  def showhide
  	puts "I went to the showhide route"
  	session[:hide] = true
  	redirect_to '/'
  end

  def new
  end

  def create
  	@task = Todo.new({item:params[:item],due:params[:duedate]})
	@task.user_id = session[:id]
	@task.save
	redirect_to '/' 
  end

  def update
  	@task = Todo.find(params[:id])
  	@task.update(checkbox:params[:done])
  	@task.save
  	redirect_to '/'
  end

end
