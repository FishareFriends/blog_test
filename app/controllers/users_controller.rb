class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]

	def new
		@user = User.new
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "Your account info was updates"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def index
		# perform a paginated query, using an explicit "per page" limit:
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome to Test Blog #{@user.username}, you're signed up"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

end