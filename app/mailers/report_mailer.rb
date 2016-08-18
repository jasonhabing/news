class ReportMailer < ActionMailer::Base
  default from: "jasonhabing@gmail.com"

  def report_email
    email = "jasonhabing@gmail.com"
    mail(to: email, subject: 'Daily Calm Fortress Report')
  end

end
