class FriendsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_friend, only: %i[show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  

  
  def index
    @q = Friend.ransack(params[:q])
    @friends = @q.result.includes(:user).page(params[:page])
     # @friends = Friend.all.page(params[:page])  

  end
  
  def show
  end

  
  def new
    # @friend = Friend.new
    @friend = current_user.friends.build
  end

  
  def edit
  end

  
  def create
    # @friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
           # current_user.add_role :creator, @friend

        SendingEmailJob.set(wait: 5.seconds).perform_later(@friend)

        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        # current_user.add_role :editor, @friend
        SendingEmailJob.set(wait: 10.seconds).perform_later(@friend)

        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy
            

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def  acceptable_image
    return unless profile_image.attached?
  end
  
  def correct_user
    @users = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized to edit this Friend" if @friend.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

   
    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :address, :user_id, :profile_image, :search)
    end
end
