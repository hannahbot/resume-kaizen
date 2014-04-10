class SubmitterResumePolicy < ApplicationPolicy
  attr_reader :user, :resume

  def initialize(user, resume)
    @user = user
    @resume = resume
  end

  def show?
    true
  end


end
