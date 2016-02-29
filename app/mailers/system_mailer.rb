class SystemMailer < ActionMailer::Base

  default from: 'noreply@bookstore.com'

  def activate_your_account(user)
    @user = user
    @link = url_for(controller: 'authentication', action: 'confirm_email', id: user.id)
    mail(to: @user.email, subject: 'Please confirm your email address')
  end

end