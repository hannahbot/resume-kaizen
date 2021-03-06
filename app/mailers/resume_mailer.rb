class ResumeMailer < ActionMailer::Base
  default from: "resumekaizen@example.com"

  def new_resume(user, resume)
    @resume = resume
    @user = user

    headers["Message-ID"] = "<resume/#{@resume.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<resume/#{@resume.id}@your-app-name.example>"
    headers["References"] = "<resume/#{@resume.id}@your-app-name.example>"
    mail(to: resume.email, subject: "New resume on #{resume.name}")
  end

end
