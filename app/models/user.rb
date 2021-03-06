class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :resumes
  has_many :messages, dependent: :destroy


  def submitter?
    role == "submitter"
  end

  def reviewer?
    role == "reviewer"
  end

  #overrides has_many
  def resumes
    (Resume.where(user_id: id, archived: false).pluck(:group_id) + Resume.where(reviewer_id: id, archived: false).pluck(:group_id))

    # (Resume.where(user_id: id).pluck(:group_id) + Resume.where(reviewer_id: id).pluck(:group_id)).uniq!
    #resumes i own + resumes i review
  end
  
end
