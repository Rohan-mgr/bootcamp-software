class CustomerMailer < ApplicationMailer
  def order_deletion_email(customer, order, organization)
    @customer = customer
    @order = order
    @organization = organization
    mail(to: @customer[:email], from: "Bootcamp SAAS", subject: "Information about order deletion")
  end
end
