class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def authenticate_user
		if current_sme_user.blank? && current_vendor.blank? && current_admin.blank?
			redirect_to '/sme_users/sign_in'
		end
	end

    def validate_sme_user
      if current_sme_user.present? && current_sme_user.active == false
        redirect_to root_url, notice: 'SME account is not active'
      end
    end

    def validate_vendor
      if current_vendor.present? && current_vendor.active == false
        redirect_to root_url, notice: 'Vendor account is not active'
      end
    end
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :password_confirmation])
    end
end
