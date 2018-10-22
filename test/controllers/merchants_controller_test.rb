require "test_helper"

describe MerchantsController do
  describe "show" do
    let(:one) { merchants(:one) }
    let(:two) { merchants(:two) }

    it "goes to merchant's dashboard view when logged in" do
      login(one)
      get merchant_path(one.id)
      must_respond_with :success
    end

    it "redirects to merchant products when not logged in" do
      get merchant_path(one.id)
      must_redirect_to merchant_products_path(one.id)
      expect(flash[:result_text]).must_include "You are not authorized to view this dashboard"
    end

    it "redirects when merchant tries to access other dashboards" do
      login(two)

      get merchant_path(one.id)

      must_redirect_to merchant_products_path(one.id)
      expect(flash[:result_text]).must_include "You are not authorized to view this dashboard"
    end

    it "redirects when merchant does not exit" do
      deadmerch = merchants(:four)
      deadmerch.destroy

      get merchant_path(deadmerch)
      must_respond_with :redirect
      expect(flash[:result_text]).must_include "Merchant could not be found"
      must_redirect_to root_path

    end
  end
end
#
#   it "does not render dashboard if merchant is not valid" do
#     @merchant = Merchant.first
#     @merchant.id = 0
#     #if the merchant is not a real merchant, does it return bad_request?
#     #if merchant is not a real merchant, does it redirect to root?
#     #if the merchant is not a real merchant, does it display errors(the whys?)?
#     result = @merchant.valid?
#     expect( result ).wont_equal true
#
#     expect{
#       post merchants_path(id: params[:id] )
#     }.must_respond_with :bad_request
#     # expect( @merchant.errors.messages ).must_include :id
#   end
#
#   it "does not render dashboard if merchant is not signed in" do
#     @merchant = Merchant.first
#     # what happens when merchant isn't signed-in; inside a session?
#     # if session[:user_id] != @merchant.id
#     expect{
#       post merchants_path(id: params[:id] )
#     }.must_respond_to :bad_request
#     # expect( @merchant.errors.messages ).must_include 'not logged in'
#     # end
#     #if the merchant is not signed in, does it redirect to sign-in?
#     #if the merchant is not signed in, does it display errors(the whys?)?
#   end
# end
#
# describe "create" do
#   it "succeeds when all data entered is valid" do
#     skip
#     #when all data in form is correct does it give a -succeed?
#     #when it succeeds, where does the data go?
#     #when it succeeds, where does the page go?
#   end
#
#   it "increases the total number of merchants by 1 if data is valid" do
#     skip
#     #when merchant is created, does merchant save?
#     #when merchant is created, does Merchant.count increase by 1?
#     #when merchant is created, does new form redirect to new merchant's dashboard?
#   end
#
#   it "does not succeed when any data entered is invalid" do
#     skip
#     #when any data in form is incorrect does it give bad_request?
#     #when it does not succeed, where does the page go?
#     #when merchant is created, does Merchant.count increase by 1?
#     #when merchant is created, does new form redirect to new merchant's dashboard?
#   end
