class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index 
        apartments = Apartment.all 
        render json: apartments
    end
    def show 
        
        apartment = Apartment.find(params[:id])
        render json: apartment
    end
    def create 
         apartment = Apartment.create!(apartment_params)
         render json: apartment, status: :created
    end


    def update 
        apartment = Apartment.find_by(params[:apartment_id])
        apartment.update!(apartment_params)
        render json: apartment, status: :accepted
    
    end

    def destroy 
        apartment = Apartment.find_by(params[:apartment_id])
        apartment.destroy
        head :no_content
    end

    private 
    def apartment_params 
        params.permit(:number)
    end
    def record_not_found 
        render json: {error: "not found" }, status: :not_found
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: 422
    end
end
 