class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:notice] = "Successfully created tutorial."
      redirect_to tutorial_path(@tutorial)
    else
      flash[:notice] = "Couldn't create tutorial."
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to tutorials_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end

  def tag_params
    params.require(:tutorial).permit(:tag_list)
  end
end
