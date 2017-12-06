class InterestsController < ApplicationController

  has_scope :by_format
  has_scope :by_local

  def index
    @interests = apply_scopes(Interest.all.includes(:user))
  end

  def new
    @interest = Interest.new
  end

  def create
    @interest = Interest.new(permitted_params)
    @interest.user_id = current_user.id

    if @interest.save
      redirect_to interests_path
      flash[:success] = "Interesse adicionado"
    else
      render :new
    end
  end

  def permitted_params
    params.require(:interest).permit(:local, :format, :datetime)
  end

end
