class Api::V1::SmeUsersController < ApplicationController
	protect_from_forgery with: :null_session
	def create
		if params[:customer_id].present?
			Shop.set_store_session
			shopify_customer = ShopifyAPI::Customer.find(params[:customer_id])
			if shopify_customer.blank?
				respond_to do |format|
		      		format.json { render json: {error: 'customer_id not found'}, status: :unprocessable_entity }
		    	end
			else
				sme_user = SmeUser.find_by_shopify_customer_id shopify_customer.id
				if sme_user.blank?
					sme_user = SmeUser.find_by_email shopify_customer.email
					if sme_user.present?
						sme_user.shopify_customer_id = shopify_customer.id
						sme_user.save
						sme_user.set_sme_user
					end
				end

				if sme_user.blank?
					sme_user = SmeUser.new(name: [shopify_customer.first_name, shopify_customer.last_name].join(' '), 
						email: shopify_customer.email, 
						active: true, 
						shopify_customer_id: shopify_customer.id,
						password: shopify_customer.email)
					sme_user.save
					sme_user.set_sme_user
				end
				if sme_user.errors.present?
				    respond_to do |format|
				      format.json { render json: {error: sme_user.errors.full_messages}, status: :unprocessable_entity }
				    end
				else
				    respond_to do |format|
				      format.json { render json: {message: 'Success', sme_user: sme_user.attributes}, status: :ok }
				    end					
				end
			end
		else
		    respond_to do |format|
		      format.json { render json: {error: 'customer_id not found'}, status: :unprocessable_entity }
		    end
		end
	end

	def show
		if params[:id].present?
			Shop.set_store_session
			shopify_customer = ShopifyAPI::Customer.find(params[:id])
			if shopify_customer.blank?
				respond_to do |format|
		      		format.json { render json: {error: 'customer_id not found'}, status: :unprocessable_entity }
		    	end
			else
				sme_user = SmeUser.find_by_shopify_customer_id shopify_customer.id
				if sme_user.blank?
				    respond_to do |format|
				      format.json { render json: {error: 'sme user not found'}, status: :unprocessable_entity }
				    end	
				else
				    respond_to do |format|
				      format.json { render json: {sme_user: sme_user.attributes}, status: :ok }
				    end	
				end
			end
		else
		    respond_to do |format|
		      format.json { render json: {error: 'customer_id not found'}, status: :unprocessable_entity }
		    end
		end
	end

	def login
		if params[:token].present?
			sme_user = SmeUser.find_by(authentication_token: params[:token])
			if sme_user.blank?
			    respond_to do |format|
			      format.json { render json: {error: 'token invalid found'}, status: :unprocessable_entity }
			    end
			else
				if current_sme_user.present? && current_sme_user == sme_user
				    respond_to do |format|
				      format.json { render json: {message: 'Success', url: "https://multivendor-prod.herokuapp.com/"}, status: :ok }
				    end
				else
					if current_sme_user.present?
						signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(:sme_user))
					end
					sign_in(:sme_user, sme_user)
				    respond_to do |format|
				      format.json { render json: {message: 'Success', url: "https://multivendor-prod.herokuapp.com/"}, status: :ok }
				    end
				end
			end
		else
		    respond_to do |format|
		      format.json { render json: {error: 'token not found'}, status: :unprocessable_entity }
		    end
		end
	end

	def logout
		if params[:token].present?
			sme_user = SmeUser.find_by(authentication_token: params[:token])
			if sme_user.blank?
			    respond_to do |format|
			      format.json { render json: {error: 'token invalid found'}, status: :unprocessable_entity }
			    end
			else
				(Devise.sign_out_all_scopes ? sign_out : sign_out(:sme_user))
			    respond_to do |format|
			      format.json { render json: {message: 'Success'}, status: :ok }
			    end
			end
		else
		    respond_to do |format|
		      format.json { render json: {error: 'token not found'}, status: :unprocessable_entity }
		    end
		end
	end

end