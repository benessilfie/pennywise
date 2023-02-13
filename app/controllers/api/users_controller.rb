class Api::UsersController < ApiController
  before_action :set_user, only: %i[show update]
  before_action :check_user, only: %i[update]

  def index
    @users = User.all.order(id: :asc)
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      render json: {
        message: 'User created successfully',
        data: @user
      }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {
        message: 'User updated successfully',
        data: @user.as_json(only: %i[first_name last_name email dob address updated_at])
      }, status: :ok
    else
      render json: {
        message: 'User update failed',
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:id, :first_name, :last_name, :email, :password, :dob, :address).compact
  end
end
