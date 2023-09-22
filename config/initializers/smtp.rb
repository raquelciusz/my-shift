ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'gmail.com',
  user_name: 'myshiftprojectruby@gmail.com',
  password: 'RegistrationsController#create',
  authentication: :login,
  enable_starttls_auto: true
}
