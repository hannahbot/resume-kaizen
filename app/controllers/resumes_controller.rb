class ResumesController < ApplicationController
  respond_to :html, :js

  def index
    @resumes = resumes_array
    @resume = Resume.new
  end

  def show
    @resume = Resume.find(params[:id])
  end
  
  def new
    @resume = Resume.new
    @group_id = params[:group_id]
    @name = params[:name]
    @reviewer_id = params[:reviewer_id]
    @user_id = params[:user_id]
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user_id = current_user.id
    @resume.email = current_user.email

    @resume.name = User.find(params[:resume][:reviewer_id]).name   
    
    if @resume.save
      ResumeMailer.new_resume(@user, @resume).deliver
      flash[:notice] = "Resume submitted."
      redirect_to resumes_path
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end

  end
  
  def destroy
    @resume = Resume.find(params[:id])
    if @resume.update_attribute(:archived, true)
      flash[:notice] = "The resume #{@resume.name} has been archived."
    else
      flash[:error] = "There was an error. Please try again."
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:name, :email, :file, :reviewer_id, :user_id, :group_id, :job_link, :job_description, :price, :search)
  end

  def resumes_array
  group_id_collection = current_user.resumes
    #One line to collect all of the ids
    resumes = {}
    #A second line to iterate through the ids and create the arrays
    group_id_collection.each do |group_id|
      resumes[group_id] = Resume.where(group_id: group_id)
    end

    return resumes
  end

end