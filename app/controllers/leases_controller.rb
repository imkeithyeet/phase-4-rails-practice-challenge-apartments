class LeasesController < ApplicationController
   rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
   rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
   
   def index 
    leases = Lease.all
    render json: leases
   end

 def show 
   lease = Lease.find_by(params[:id])
   render json: lease, status: :ok
 end

 def create 
   lease = Lease.create!(lease_params)
   render json: lease, status: :created
end

def destroy 
   lease = Lease.find_by(params[:id])
   lease.destroy
   head :no_content
end
private 
def lease_params
   params.permit(:apartment_id, :tenant_id, :rent)
end
def record_not_found 
   render json: {error: "not found" }, status: :not_found
end

def record_invalid(invalid)
   render json: {errors: invalid.record.errors.full_messages}, status: 422
end
end
